resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = module.aks.aks_resource_group_name
  location                 = azurerm_resource_group.es-demo-resource-group.location
  account_tier             = "Standard"
  account_replication_type = "GRS" # (Geo-redundant storage)The data will be replicated in a secondary region.

  tags = var.default_tags
  depends_on = [
    azurerm_resource_group.es-demo-resource-group
  ]
}


resource "kubernetes_secret" "sa_secret" {
  metadata {
    name      = "azurefile-secret"
  }
  data = {
    azurestorageaccountname = azurerm_storage_account.sa.name
    azurestorageaccountkey  = azurerm_storage_account.sa.primary_access_key
  }
  type       = "Opaque"
}


resource "kubernetes_storage_class" "azurefile" {
  metadata {
    name = "azurefile-custom"
  }
  storage_provisioner = "file.csi.azure.com"
  reclaim_policy      = "Delete"
  parameters = {
    storageAccount  = azurerm_storage_account.sa.name
    location        = azurerm_storage_account.sa.location
    secretName      = kubernetes_secret.sa_secret.metadata.0.name
    secretNamespace = "default"
  }
  mount_options = ["file_mode=0777", "dir_mode=0777", "mfsymlinks", "uid=1000", "gid=1000", "nobrl", "cache=none"]
}
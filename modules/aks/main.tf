resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.aks_location
  resource_group_name = var.aks_resource_group
  sku_tier            = "Free"

  default_node_pool {
    name                = "default"
    vm_size             = var.k8s_vm_size
    min_count           = var.default_pool_min_node_count
    max_count           = var.default_pool_max_node_count 
    zones               = [1, 2, 3]
    enable_auto_scaling = true
  }

  service_principal {
    client_id     = var.aks_service_principal_client_id
    client_secret = var.aks_service_principal_client_secret
  }

  dns_prefix = var.aks_dns_prefix

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  kubernetes_version                = "1.23.8"
  role_based_access_control_enabled = true
  auto_scaler_profile {
    expander                      = "least-waste"
    skip_nodes_with_local_storage = true
    skip_nodes_with_system_pods   = true
    scale_down_unneeded           = "5m"
  }

  tags = var.default_tags
}

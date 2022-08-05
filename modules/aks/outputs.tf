output "kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "kubernetes_cluster_version" {
  value = azurerm_kubernetes_cluster.aks.kubernetes_version
}

output "aks_host" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "aks_client_key" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
}

output "aks_client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}

output "aks_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
}

output "aks_resource_group_name" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}


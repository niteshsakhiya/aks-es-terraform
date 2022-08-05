resource "azurerm_kubernetes_cluster_node_pool" "kubernetes_node_pool" {
  for_each = var.nodepool_details

  name                  = each.value.name
  kubernetes_cluster_id = each.value.cluster_id
  orchestrator_version  = each.value.orchestrator_version
  vm_size               = each.value.vm_size
  max_count             = each.value.max_count
  min_count             = each.value.min_count
  enable_auto_scaling   = each.value.enable_auto_scaling
  node_labels           = each.value.node_labels
  node_taints           = each.value.node_taints
  zones                 = each.value.zones
  tags                  = each.value.tags
}
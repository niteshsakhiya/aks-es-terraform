
# Create resource group on Azure cloud
resource "azurerm_resource_group" "es-demo-resource-group" {
  location = var.resource_group_location
  name     = "${var.resource_group_name}-rg"
}

# Create module to provision managed Kubernetes cluster on Azure
module "aks" {
  source = "../modules/aks"

  aks_cluster_name   = "${var.environment_name}-aks"
  aks_location       = azurerm_resource_group.es-demo-resource-group.location
  aks_resource_group = azurerm_resource_group.es-demo-resource-group.name

  aks_service_principal_client_id     = var.service_principal_client_id
  aks_service_principal_client_secret = var.service_principal_client_secret
  aks_dns_prefix                      = "${var.environment_name}-aks"

  k8s_vm_size               = var.k8s_vm_size
  k8s_cluster_node_count    = var.k8s_cluster_node_count
  
  default_tags              = var.default_tags
}


# Create nodepools for Elasticsearch master, data, and coordinating nodes
module "aks_nodepool" {
  source = "../modules/nodepool"

  nodepool_details = {
    "elasticsearch-master" : {
      "name"                    : "elmaster",
      "cluster_id"              : module.aks.kubernetes_cluster_id,
      "orchestrator_version"    : module.aks.kubernetes_cluster_version,
      "vm_size"                 : var.elasticsearch_master_pool_vm_size,
      "zones"                   : [1,2,3]
      "min_count"               : 3,
      "max_count"               : 6,
      "enable_auto_scaling"     : true
      "node_labels"             : {
        "node_type"                      : "elastic"
        "node.kubernetes.io/component"   : "master"
      },
      "node_taints"             : ["allow=elastic-master:NoSchedule"]
      "tags"                    : var.default_tags
    },
    "elasticsearch-data" : {
      "name"                    : "eldata",
      "cluster_id"              : module.aks.kubernetes_cluster_id,
      "orchestrator_version"    : module.aks.kubernetes_cluster_version,
      "vm_size"                 : var.elasticsearch_data_pool_vm_size,
      "zones"                   : [1,2,3]
      "min_count"               : 3,
      "max_count"               : 10,
      "enable_auto_scaling"     : true
      "node_labels"             : {
        "node_type"                      : "elastic"
        "node.kubernetes.io/component"   : "data"
      },
      "node_taints"             : ["allow=elastic-data:NoSchedule"]
      "tags"                    : var.default_tags
    },
    "elasticsearch-coordinating" : {
      "name"                    : "elcoordinate",
      "cluster_id"              : module.aks.kubernetes_cluster_id,
      "orchestrator_version"    : module.aks.kubernetes_cluster_version,
      "vm_size"                 : var.elasticsearch_coordinating_pool_vm_size,
      "zones"                   : [1,2,3]
      "min_count"               : 2,
      "max_count"               : 4,
      "enable_auto_scaling"     : true
      "node_labels"             : {
        "node_type"                      : "elastic"
        "node.kubernetes.io/component"   : "coordinating-only"
      },
      "node_taints"             : ["allow=elastic-coordinating:NoSchedule"]
      "tags"                    : var.default_tags
    }
  }
  depends_on = [
    module.aks.azurerm_kubernetes_cluster
  ]
}


# Create load balancer IP to allow incoming connection in the cluster from the internet
resource "azurerm_public_ip" "load_balancer" {
  name                = "load-balancer"
  location            = azurerm_resource_group.es-demo-resource-group.location
  resource_group_name = module.aks.aks_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "elasticsearch-demo"
  tags                = var.default_tags
}



variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "aks_location" {
  description = "The azure region where the cluster will be created"
  type = string
}

variable "aks_resource_group" {
  description = "The resource group in which the cluster will be created"
  type = string
}

variable "k8s_cluster_node_count" {
  description = "The number of kubernetes nodes for the default nodepool"
  type        = number
}

variable "k8s_vm_size" {
  description = "The Azure VM Size for the standard nodepool"
  type        = string
  default     = "Standard_D2as_v4"
}

variable "aks_service_principal_client_id" {
  description = "USE TF_VAR_service_principal_client_id! The client ID of the service principal that will be used to create the AKS cluster."
  type        = string
}

variable "aks_service_principal_client_secret" {
  description = "USE TF_VAR_service_principal_client_secret! The secret of the service principal that will be used to create the AKS cluster."
  type = string
}

variable "aks_dns_prefix" {
  description = "The DNS prefix used for the AKS cluster"
  type = string
}

variable "default_tags" {
  type = map
}

variable "default_pool_min_node_count" {
  type = number
  default = 2
}

variable "default_pool_max_node_count" {
  type = number
  default = 10
}

variable "environment_name" {
  description = "Name of the environment"
  type        = string
}

variable "resource_group_location" {
  description = "Geographic location of the resource group"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "service_principal_client_id" {
  description = "USE TF_VAR_service_principal_client_id! The client ID of the service principal that will be used to create the AKS cluster."
  type        = string
}

variable "service_principal_client_secret" {
  description = "USE TF_VAR_service_principal_client_secret! The secret of the service principal that will be used to create the AKS cluster."
}

variable "default_tags" {
  description = "Default tags"
  type = map
  default = {
    Created_by : "Nitesh Sakhiya",
    Purpose : "Elasticsearch Demo",
  }
}

variable "k8s_vm_size" {
  description = "The Azure VM Size"
  type        = string
  default     = "Standard_D2as_v4"
}

variable "k8s_cluster_node_count" {
  description = "The number of kubernetes nodes to create for the k8s cluster"
  type        = number
  default     = 3
}

variable "elasticsearch_data_pool_vm_size" {
  description = "The Azure VM Size for elasticsearch data nodepool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "elasticsearch_master_pool_vm_size" {
  description = "The Azure VM Size for elasticsearch master nodepool"
  type        = string
  default     = "Standard_B2s"
}

variable "elasticsearch_coordinating_pool_vm_size" {
  description = "The Azure VM Size for elasticsearch coordinating nodepool"
  type        = string
  default     = "Standard_B2s"
}

variable "elasticsearch_min_node_count" {
  description = "The number of kubernetes nodes to create for the k8s cluster"
  type        = number
  default     = 2
}

variable "elasticsearch_max_node_count" {
  description = "The number of kubernetes nodes to create for the k8s cluster"
  type        = number
  default     = 10
}

variable "storage_account_name" {
  description = "Name of the Azure storage account"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "USE TF_VAR_cloudflare_zone_id! The cloudflare DNS zone id"
  type    = string
  default = ""
}


variable "persistent-volume-mount-options" {
  type    = list
  default = ["dir_mode=0777", "file_mode=0777", "uid=1000", "gid=1000", "mfsymlinks", "nobrl"]
}


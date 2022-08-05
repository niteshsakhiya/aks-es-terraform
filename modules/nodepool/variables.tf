variable "nodepool_details" {
  description = "Description of the nodepool to be created/updated"
  type        = map(object({
    name                    = string
    cluster_id              = string
    orchestrator_version    = string
    vm_size                 = string
    zones                   = set(string)
    min_count               = number
    max_count               = number
    enable_auto_scaling     = bool
    node_labels             = map(string)
    node_taints             = set(string)
    tags                    = object({})
  }))
}

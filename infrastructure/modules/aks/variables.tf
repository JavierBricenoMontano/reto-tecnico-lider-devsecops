
variable "name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where to create the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "network_plugin" {
  description = "Network plugin to use for AKS"
  type        = string
  default     = "kubenet"
}

variable "acr_id" {
  description = "ID of the ACR to assign permissions to"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to the AKS cluster"
  type        = map(string)
  default     = {}
}

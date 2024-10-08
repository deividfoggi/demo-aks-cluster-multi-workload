variable "node_pool_name" {
  description = "The name of the AKS node pool"
  type        = string
}

variable "aks_cluster_id" {
  description = "The ID of the AKS cluster"
  type        = string
}

variable "nodepool_vmsize" {
  description = "The VM size of the AKS node pool"
  type        = string
}

variable "nodepool_priority" {
  description = "The priority of the AKS node pool"
  type        = string
}

variable "min_count" {
  description = "The minimum count of the AKS node pool"
  type        = number
}

variable "max_count" {
  description = "The maximum count of the AKS node pool"
  type        = number
}

variable "max_pods" {
  description = "The maximum pods of the AKS node pool"
  type        = number
}

variable "mode" {
  description = "The mode of the AKS node pool"
  type        = string
}

variable "os_disk_type" {
  description = "The OS disk type of the AKS node pool"
  type        = string
}

variable "subnet_pool_id" {
  description = "The subnet ID of the AKS node pool"
  type        = string
}

variable "node_pool_zones" {
  description = "The zones where to deploy nodes"
  type = list(string)
}

variable "app_label_taint" {
  description = "The app label taint of the AKS node pool"
  type        = string
}
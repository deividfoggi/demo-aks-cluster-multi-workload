variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable  "node_resource_group" {
  description = "The name of the nodes/infra resource group"
  type        = string
}

variable "aks_cluster_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
} 

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "aks_sku_tier" {
  description = "The SKU tier of the AKS cluster"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the log analytics workspace"
  type        = string
}

variable "aks_system_nodepool_vmsize" {
  description = "The VM size of the system node pool"
  type        = string
}

variable "aks_os_disk_type" {
  description = "The OS disk type of the AKS cluster"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID of the AKS cluster"
  type        = string
}

variable aks_cluster_zones {
  description = "The zones of the AKS cluster"
  type        = list(string)
}

variable "web_app_routing_dns_zone_ids" {
  description = "The DNS zone IDs for web app routing"
  type        = list(string)
}
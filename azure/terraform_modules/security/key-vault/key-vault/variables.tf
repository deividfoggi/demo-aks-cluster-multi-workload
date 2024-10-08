variable "name" {
  description = "The prefix for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "tenant_id" {
  description = "The tenant id"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Whether or not to enable public network access"
  type        = bool
}
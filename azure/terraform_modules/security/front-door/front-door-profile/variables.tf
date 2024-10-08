
variable "prefix" {
  description = "The prefix for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "The SKU of the front door profile"
  type        = string
}
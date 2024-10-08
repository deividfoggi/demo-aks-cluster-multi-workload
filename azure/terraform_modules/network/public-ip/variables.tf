variable "name" {
  type = string
  description = "The name of the public IP."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which the public IP will be created."
}

variable "location" {
  type = string
  description = "The location/region in which the public IP will be created."
}

variable "allocation_method" {
  type = string
  description = "The allocation method of the public IP."
  default = "Static"
}

variable "sku" {
  type = string
  description = "The SKU of the public IP."
  default = "Standard"
}
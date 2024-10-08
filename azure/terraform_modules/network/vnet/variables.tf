variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which the virtual network will be created."
}

variable "location" {
  type = string
  description = "The location/region in which the virtual network will be created."
}

variable "vnet_name" {
  type = string
  description = "The name of the virtual network."
}

variable "vnet_address_space" {
  type = list(string)
  description = "The address space that is used the virtual network."
}
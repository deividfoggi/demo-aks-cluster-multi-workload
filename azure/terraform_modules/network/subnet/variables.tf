variable "name" {
  type = string
  description = "The name of the subnet."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the virtual network."
}

variable "virtual_network_name" {
  type = string
  description = "The name of the virtual network."
}

variable "address_prefixes" {
  type = list(string)
  description = "The address prefixes to use for the subnet."
}

variable "private_link_service_network_policies_enabled" {
  type = bool
  description = "Enable network policies for private link service."
  default = null
}

variable "subnet_delegation_enabled" {
  type = bool
  description = "Enable subnet delegation."
  default = false
}

variable "delegation_name" {
  type = string
  description = "The name of the subnet delegation."
  default = null
}

variable "service_delegation_name" {
  type = string
  description = "The name of the service delegation."
  default = null
}

variable "service_delegation_actions" {
  type = list(string)
  description = "The actions of the service delegation."
  default = null
}
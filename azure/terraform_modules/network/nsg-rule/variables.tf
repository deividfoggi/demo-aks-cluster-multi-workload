variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which the NSG will be created."
}

variable "network_security_group_name" {
  type = string
  description = "The name of the network security group."
}

variable "network_security_rules" {
  description = "The rules to be added to the nsg."
    type = list(object({
      name = string
      priority = number
      direction = string
      access = string
      protocol = string
      source_port_range = string
      destination_port_range = string
      source_address_prefix = string
      destination_address_prefix = string
  }))
}
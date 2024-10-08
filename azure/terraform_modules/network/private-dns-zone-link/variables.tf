variable "name" {
    type = string
    description = "The name of the private DNS zone."
}

variable "resource_group_name" {
    type = string
    description = "The name of the resource group in which to create the private DNS zone."
}

variable "private_dns_zone_name" {
    type = string
    description = "The name of the private DNS zone."
}

variable "virtual_network_id" {
    type = string
    description = "The ID of the virtual network to link to the private DNS zone."
}

variable "registration_enabled" {
    type = bool
    description = "Whether or not to register virtual network in the private DNS zone."
}
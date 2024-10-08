variable "name" {
  type = string
  description = "The name of the private endpoint"
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the resources."
}

variable "location" {
  type = string
  description = "The location/region in which the resources will be created."
}

variable "subnet_id" {
  type = string
  description = "The ID of the subnet to associate with the private endpoint."
}

variable "private_service_connection_name" {
  type = string
  description = "The name of the private service connection."
}

variable "private_connection_subresource_names" {
  type = list(string)
  description = "The subresource names to connect to."
}

variable "private_connection_is_manual_connection" {
  type = bool
  description = "Whether the connection is manual or not.	Default is false."
}

variable "private_connection_resource_id" {
  type = string
  description = "The ID of the resource to connect to."
}

variable "dns_zone_group_name" {
  type = string
  description = "The name of the private DNS zone group."
}

variable "dns_zone_id" {
  type = string
  description = "The ID of the private DNS zone."
}
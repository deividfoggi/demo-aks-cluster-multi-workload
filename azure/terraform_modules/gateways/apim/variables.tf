variable resource_group_name {
    type = string
    description = "The name of the resource group in which to create the resources."
}
variable location {
    type = string
    description = "The location/region in which the resources will be created."
}

variable "name" {
  type = string
  description = "The name of the API Management service."
}

variable "sku_name" {
  type = string
  description = "The SKU of the API Management service."
}	

variable "publisher_name" {
  type = string
  description = "The publisher name of the API Management service."
}

variable "publisher_email" {
  type = string
  description = "The publisher email of the API Management service."
}

variable "virtual_network_type" {
  type = string
  description = "The virtual network type of the API Management service."
}

variable "subnet_id" {
  type = string
  description = "The subnet ID of the API Management service."
}

variable "identity_type" {
  type = string
  description = "The identity type of the API Management service."
}

variable "applicationinsights_instrumentation_key" {
  type = string
  description = "The application insights instrumentation key of the API Management service."
}
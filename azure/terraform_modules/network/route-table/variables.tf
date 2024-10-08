variable "name" {
  type = string
  description = "The name of the route table."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the route table."
}

variable "location" {
  type = string
  description = "The location/region in which the public IP will be created."
}

variable "routes" {
  description = "The route to be added to the route table."
    type = list(object({
      name = string
      address_prefix = string
      next_hop_type = string
  }))
}
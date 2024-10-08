variable "name" {
    type = string
    description = "The name of the subnet to which the NSG will be associated."
}

variable "resource_group_name" {
    type = string
    description = "The name of the resource group in which to create the NSG."
}

variable "location" {
    type = string
    description = "The location/region in which the NSG will be created."
}
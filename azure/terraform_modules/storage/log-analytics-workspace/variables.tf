variable "name" {
  type = string
  description = "The name of the Log Analytics workspace."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the Log Analytics workspace."
}

variable "location" {
  type = string
  description = "The location/region in which the Log Analytics workspace will be created."
}

variable "sku" {
  type = string
  description = "The SKU of the Log Analytics workspace."
  default = "PerGB2018"
}

variable "retention_in_days" {
  type = number
  description = "The retention period for the logs in days."
  default = 30
}
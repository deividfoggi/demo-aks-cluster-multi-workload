variable "name" {
  type = string
  description = "The name of the application insights."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the application insights."
}

variable "location" {
  type = string
  description = "The location/region in which the application insights will be created."
}

variable "workspace_id" {
  type = string
  description = "The workspace ID of the Log Analytics workspace."
}

variable "application_type" {
  type = string
  description = "The type of the application insights."
  default = "web"
}
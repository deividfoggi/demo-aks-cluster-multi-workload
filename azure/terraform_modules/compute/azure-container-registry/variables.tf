variable "name" {
  description = "The name of the Azure Container Registry"
  type        = string
}

variable "location" {
  description = "The location of the Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Azure Container Registry will be created"
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
}
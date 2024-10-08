variable "name" {
  type = string
  description = "The name of the Azure Cognitive Services Account."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the Azure Cognitive Services Account."
}

variable "location" {
  type = string
  description = "The location/region in which the Azure Cognitive Services Account will be created."
}

variable "kind" {
  type = string
  description = "The kind of the Azure Cognitive Services Account."
}

variable "sku" {
  type = string
  description = "The SKU of the Azure Cognitive Services Account."
  default = "S0"
}

variable "custom_subdomain_name" {
  type = string
  description = "The custom subdomain name of the Azure Cognitive Services Account."
}

variable "network_acls_ignore_missing_endpoints" {
  type = bool
  description = "A boolean flag that specifies whether to ignore missing service endpoints."
  default = true
}

variable "network_acls_subnet_id" {
  type = string
  description = "The ID of the subnet to associate with the Azure Cognitive Services Account."
}
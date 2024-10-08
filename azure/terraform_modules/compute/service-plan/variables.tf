variable service_plan_name {
  type        = string
  default     = ""
  description = "The name for this Service Plan"
}
variable resource_group_name {
  type        = string
  default     = ""
  description = "Name of the resource group"
}
variable location {
  type        = string
  default     = ""
  description = "The location of the resources deployed by this module"
}
variable service_plan_sku {
  type        = string
  default     = ""
  description = "SKU name of this Service Plan"
}
variable service_plan_os_type {
  type        = string
  default     = ""
  description = "The OS: Windows or Linux"
}
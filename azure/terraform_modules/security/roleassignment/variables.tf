variable "scope_resource_id" {
  type = string
  description = "The scope at which the role assignment will be created."
}

variable "role_definition_name" {
  type = string
  description = "The ID of the role definition to assign."
}

variable "principal_id" {
  type = string
  description = "The ID of the principal to assign the role to."
}
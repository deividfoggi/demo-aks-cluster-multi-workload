variable "key_vault_id" {
  description = "The ID of the key vault"
  type        = string
}

variable "service_principal_object_id" {
  description = "The object ID of the service principal"
  type        = string
}

variable "secret_permissions" {
  description = "The permissions for the secrets"
  type        = list(string)
}

variable "key_permissions" {
  description = "The permissions for the keys"
  type        = list(string)
}

variable "certificate_permissions" {
  description = "The permissions for the certificates"
  type        = list(string)
}
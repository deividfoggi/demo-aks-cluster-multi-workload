variable "certificate_name" {
  description = "The name of the certificate"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the key vault"
  type        = string
}

variable "certificate_path" {
  description = "The path to the certificate"
  type        = string
}

variable "certificate_password" {
  description = "The password for the certificate"
  type        = string
}
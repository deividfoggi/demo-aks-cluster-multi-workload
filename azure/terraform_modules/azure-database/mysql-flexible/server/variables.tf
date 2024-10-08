variable "name" {
  description = "The name of the MySQL server"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the MySQL server is created"
}

variable "location" {
  description = "The location of the MySQL server"
}

variable "administrator_login" {
  description = "The administrator login of the MySQL server"
}

variable "administrator_password" {
  description = "The administrator password of the MySQL server"
}

variable "backup_retention_days" {
  description = "The backup retention days of the MySQL server"
}

variable "delegated_subnet_id" {
  description = "The delegated subnet id of the MySQL server"
}

variable "private_dns_zone_id" {
  description = "The private dns zone id of the MySQL server"
}

variable "sku_name" {
  description = "The sku name of the MySQL server"
}

variable "zone" {
  description = "The zones of the MySQL server"
  type = string
}

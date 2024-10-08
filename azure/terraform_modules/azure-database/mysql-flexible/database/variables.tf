variable "name" {
  description = "The name of the MySQL database"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the MySQL database is created"
}

variable "mysql_server_name" {
  description = "The name of the MySQL server"
}

variable "charset" {
  description = "The charset of the MySQL database"
}

variable "collation" {
  description = "The collation of the MySQL database"
}
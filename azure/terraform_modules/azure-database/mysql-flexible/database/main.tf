resource "azurerm_mysql_flexible_database" "mysql_flexible_database" {
    name                = var.name
    resource_group_name = var.resource_group_name
    server_name         = var.mysql_server_name
    charset             = var.charset
    collation           = var.collation
}
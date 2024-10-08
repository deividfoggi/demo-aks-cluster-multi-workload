resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
    name                   = var.name
    resource_group_name    = var.resource_group_name
    location               = var.location
    administrator_login    = var.administrator_login
    administrator_password = var.administrator_password
    backup_retention_days  = var.backup_retention_days
    delegated_subnet_id    = var.delegated_subnet_id
    private_dns_zone_id    = var.private_dns_zone_id
    sku_name               = var.sku_name
    zone                   = var.zone
}
resource "azurerm_private_link_service" "private_link_service" {
    name = var.name
    resource_group_name = var.resource_group_name
    location = var.location

    load_balancer_frontend_ip_configuration_ids = var.load_balancer_frontend_ip_configuration_ids

    nat_ip_configuration {
        name = var.nat_ip_configuration_name
        subnet_id = var.nat_ip_configuration_subnet_id
        primary = true
    }
}
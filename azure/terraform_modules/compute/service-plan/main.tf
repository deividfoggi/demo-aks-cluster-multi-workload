resource "azurerm_service_plan" "service_plan" {
    name                = var.service_plan_name
    location            = azurerm_resource_group.resource_group.location
    resource_group_name = azurerm_resource_group.resource_group.name

    os_type             = var.service_plan_os_type
    sku_name            = var.service_plan_sku
}
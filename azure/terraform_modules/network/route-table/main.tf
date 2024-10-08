resource "azurerm_route_table" "route_table" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}

locals {
    selected_route = azurerm_route_table.route_table.name
}

resource "azurerm_route" "routes" {
  count               = length(var.routes)
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.route_table.name
  name                = var.routes[count.index].name
  address_prefix      = var.routes[count.index].address_prefix
  next_hop_type       = var.routes[count.index].next_hop_type
}
resource "azurerm_network_security_rule" "nsg_rule" {
  count = length(var.network_security_rules)
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group_name
  name                        = var.network_security_rules[count.index].name
  priority                    = var.network_security_rules[count.index].priority
  direction                   = var.network_security_rules[count.index].direction
  access                      = var.network_security_rules[count.index].access
  protocol                    = var.network_security_rules[count.index].protocol
  source_port_range           = var.network_security_rules[count.index].source_port_range
  destination_port_range      = var.network_security_rules[count.index].destination_port_range
  source_address_prefix       = var.network_security_rules[count.index].source_address_prefix
  destination_address_prefix  = var.network_security_rules[count.index].destination_address_prefix
}
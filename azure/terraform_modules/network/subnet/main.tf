// create subnets resources using a foreach
resource "azurerm_subnet" "subnet" {
  name                                          = var.name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.virtual_network_name
  address_prefixes                              = var.address_prefixes
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled

  // add subnet delegation if subnet_delegation_enabled is true
  dynamic "delegation" {
    for_each = var.subnet_delegation_enabled == true ? [1] : []
    content {
      name = var.delegation_name
      service_delegation {
        name    = var.service_delegation_name
        actions = var.service_delegation_actions
      }
    }
  }
}
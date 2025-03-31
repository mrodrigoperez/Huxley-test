resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

# Optional: We can create subnets if it's necessary, for example subnet only for the database and delegate the database
resource "azurerm_subnet" "this" {
  for_each = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes

  # A good and time-saving practice is to use a Network Security Group if provided
  network_security_group_id = each.value.nsg_id != "" ? each.value.nsg_id : null
}

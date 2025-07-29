resource "azurerm_virtual_network" "transit_vnet" {
  name                = "${local.prefix}-transit-vnet"
  location            = var.location
  resource_group_name = var.rg_transit
  address_space       = [var.cidr_transit]
  tags                = local.tags
}
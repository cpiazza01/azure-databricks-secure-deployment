resource "azurerm_virtual_network" "transit_vnet" {
  name                = "${local.prefix}-transit-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_transit.name
  address_space       = [var.cidr_transit]
  tags                = local.tags
}

resource "azurerm_virtual_network" "app_vnet" {
  name                = "${local.prefix}-app-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_dp.name
  address_space       = [var.cidr_dp]
  tags                = local.tags
}
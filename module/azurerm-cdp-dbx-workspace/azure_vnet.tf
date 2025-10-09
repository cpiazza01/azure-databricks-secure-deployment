resource "azurerm_virtual_network" "azure_dbx_vnet" {
  name                = "${local.prefix}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.azure_dbx_vnet_cidr]
  tags                = local.tags
}

resource "azurerm_virtual_network" "azure_dbx_vnet" {
  name                = "${local.prefix}-vnet"
  location            = var.location
  resource_group_name = var.azure_dbx_resource_group
  address_space       = [var.azure_dbx_vnet_cidr]
  tags                = local.tags
}

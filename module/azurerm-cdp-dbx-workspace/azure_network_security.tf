###########
# TRANSIT #
###########

resource "azurerm_network_security_group" "azuredbx_network_security_group" {
  name                = "${local.prefix}-nsg"
  location            = var.location
  resource_group_name = var.azure_dbx_resource_group
  tags                = local.tags
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.azure_dbx_public_subnet.id
  network_security_group_id = azurerm_network_security_group.azuredbx_network_security_group.id
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.azure_dbx_private_subnet.id
  network_security_group_id = azurerm_network_security_group.azuredbx_network_security_group.id
}

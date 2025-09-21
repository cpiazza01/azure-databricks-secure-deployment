###########
# TRANSIT #
###########

resource "azurerm_network_security_group" "transit_sg" {
  name                = "${local.prefix}-transit-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_transit.name
  tags                = local.tags
}

resource "azurerm_network_security_rule" "transit_aad" {
  name                        = "AllowAAD-transit"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "AzureActiveDirectory"
  resource_group_name         = azurerm_resource_group.rg_transit.name
  network_security_group_name = azurerm_network_security_group.transit_sg.name
}

resource "azurerm_network_security_rule" "transit_azfrontdoor" {
  name                        = "AllowAzureFrontDoor-transit"
  priority                    = 201
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "AzureFrontDoor.Frontend"
  resource_group_name         = azurerm_resource_group.rg_transit.name
  network_security_group_name = azurerm_network_security_group.transit_sg.name
}

resource "azurerm_subnet_network_security_group_association" "transit_public" {
  subnet_id                 = azurerm_subnet.transit_public.id
  network_security_group_id = azurerm_network_security_group.transit_sg.id
}

resource "azurerm_subnet_network_security_group_association" "transit_private" {
  subnet_id                 = azurerm_subnet.transit_private.id
  network_security_group_id = azurerm_network_security_group.transit_sg.id
}

#######
# APP #
#######
resource "azurerm_network_security_group" "app_sg" {
  name                = "${local.prefix}-app-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_dp.name
  tags                = local.tags
}

resource "azurerm_network_security_rule" "app_aad" {
  name                        = "AllowAAD-app"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "AzureActiveDirectory"
  resource_group_name         = azurerm_resource_group.rg_dp.name
  network_security_group_name = azurerm_network_security_group.app_sg.name
}

resource "azurerm_network_security_rule" "app_azfrontdoor" {
  name                        = "AllowAzureFrontDoor-app"
  priority                    = 201
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "AzureFrontDoor.Frontend"
  resource_group_name         = azurerm_resource_group.rg_dp.name
  network_security_group_name = azurerm_network_security_group.app_sg.name
}

resource "azurerm_subnet_network_security_group_association" "app_public" {
  subnet_id                 = azurerm_subnet.app_public.id
  network_security_group_id = azurerm_network_security_group.app_sg.id
}

resource "azurerm_subnet_network_security_group_association" "app_private" {
  subnet_id                 = azurerm_subnet.app_private.id
  network_security_group_id = azurerm_network_security_group.app_sg.id
}
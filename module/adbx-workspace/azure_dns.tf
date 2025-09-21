resource "azurerm_private_dns_zone" "dns_auth_front" {
  name                = "privatelink.azuredatabricks.net"
  resource_group_name = var.rg_transit
}

resource "azurerm_private_dns_zone_virtual_network_link" "transitdnszonevnetlink" {
  name                  = "dpcpspokevnetconnection"
  resource_group_name   = var.rg_transit
  private_dns_zone_name = azurerm_private_dns_zone.dns_auth_front.name
  virtual_network_id    = azurerm_virtual_network.transit_vnet.id
}

resource "azurerm_private_dns_zone" "dnsdpcp" {
  name                = "privatelink.azuredatabricks.net"
  resource_group_name = var.rg_dp
}

resource "azurerm_private_dns_zone_virtual_network_link" "uiapidnszonevnetlink" {
  name                  = "dpcpvnetconnection"
  resource_group_name   = var.rg_dp
  private_dns_zone_name = azurerm_private_dns_zone.dnsdpcp.name
  virtual_network_id    = azurerm_virtual_network.app_vnet.id
}
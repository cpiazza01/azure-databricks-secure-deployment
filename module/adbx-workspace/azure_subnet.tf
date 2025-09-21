###########
# TRANSIT #
###########

resource "azurerm_subnet" "transit_public" {
  name                 = "${local.prefix}-transit-public"
  resource_group_name  = azurerm_resource_group.rg_transit.name
  virtual_network_name = azurerm_virtual_network.transit_vnet.name
  address_prefixes     = [cidrsubnet(var.cidr_transit, 2, 0)]

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}

resource "azurerm_subnet" "transit_private" {
  name                              = "${local.prefix}-transit-private"
  resource_group_name               = azurerm_resource_group.rg_transit.name
  virtual_network_name              = azurerm_virtual_network.transit_vnet.name
  address_prefixes                  = [cidrsubnet(var.cidr_transit, 2, 1)]
  private_endpoint_network_policies = "Enabled"

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]

    }
  }

  service_endpoints = var.transit_private_subnet_endpoints
}

resource "azurerm_subnet" "transit_plsubnet" {
  name                              = "${local.prefix}-transit-privatelink"
  resource_group_name               = azurerm_resource_group.rg_transit.name
  virtual_network_name              = azurerm_virtual_network.transit_vnet.name
  address_prefixes                  = [cidrsubnet(var.cidr_transit, 2, 2)]
  private_endpoint_network_policies = "Enabled"
}

#######
# APP #
#######

resource "azurerm_subnet" "app_public" {
  name                 = "${local.prefix}-app-public"
  resource_group_name  = azurerm_resource_group.rg_dp.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = [cidrsubnet(var.cidr_dp, 2, 0)]

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}

resource "azurerm_subnet" "app_private" {
  name                                          = "${local.prefix}-app-private"
  resource_group_name                           = azurerm_resource_group.rg_dp.name
  virtual_network_name                          = azurerm_virtual_network.app_vnet.name
  address_prefixes                              = [cidrsubnet(var.cidr_dp, 2, 1)]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }

  service_endpoints = var.private_subnet_endpoints
}

resource "azurerm_subnet" "app_plsubnet" {
  name                              = "${local.prefix}-app-privatelink"
  resource_group_name               = azurerm_resource_group.rg_dp.name
  virtual_network_name              = azurerm_virtual_network.app_vnet.name
  address_prefixes                  = [cidrsubnet(var.cidr_dp, 2, 2)]
  private_endpoint_network_policies = "Enabled"
}
resource "azurerm_subnet" "azure_dbx_public_subnet" {
  name                 = "${local.prefix}-public-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.azure_dbx_vnet.name
  address_prefixes     = [cidrsubnet(var.azure_dbx_vnet_cidr, 3, 0)]

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}

resource "azurerm_subnet" "azure_dbx_private_subnet" {
  name                 = "${local.prefix}-private-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.azure_dbx_vnet.name
  address_prefixes     = [cidrsubnet(var.azure_dbx_vnet_cidr, 3, 1)]

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}
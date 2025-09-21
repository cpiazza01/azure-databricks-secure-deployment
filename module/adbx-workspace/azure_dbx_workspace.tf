resource "azurerm_databricks_workspace" "web_auth_workspace" {
  name                                  = "${local.prefix}-transit-workspace"
  resource_group_name                   = azurerm_resource_group.rg_transit.name
  location                              = var.location
  sku                                   = "premium"
  tags                                  = local.tags
  public_network_access_enabled         = false                    //use private endpoint
  network_security_group_rules_required = "NoAzureDatabricksRules" //use private endpoint
  customer_managed_key_enabled          = true
  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = azurerm_virtual_network.transit_vnet.id
    private_subnet_name                                  = azurerm_subnet.transit_private.name
    public_subnet_name                                   = azurerm_subnet.transit_public.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.transit_public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.transit_private.id
    storage_account_name                                 = local.dbfsname_transit
  }
  depends_on = [
    azurerm_subnet_network_security_group_association.transit_public,
    azurerm_subnet_network_security_group_association.transit_private
  ]
}

resource "azurerm_databricks_workspace" "app_workspace" {
  name                                  = "${local.prefix}-app-workspace"
  resource_group_name                   = azurerm_resource_group.rg_dp.name
  location                              = var.location
  sku                                   = "premium"
  tags                                  = local.tags
  public_network_access_enabled         = false                    //use private endpoint
  network_security_group_rules_required = "NoAzureDatabricksRules" //use private endpoint
  customer_managed_key_enabled          = true
  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = azurerm_virtual_network.app_vnet.id
    private_subnet_name                                  = azurerm_subnet.app_private.name
    public_subnet_name                                   = azurerm_subnet.app_public.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.app_public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.app_private.id
    storage_account_name                                 = local.dbfsname_app
  }

  depends_on = [
    azurerm_subnet_network_security_group_association.app_public,
    azurerm_subnet_network_security_group_association.app_private
  ]
}
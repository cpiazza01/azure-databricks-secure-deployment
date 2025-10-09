resource "azurerm_databricks_workspace" "azure_databricks_workspace" {
  name                        = "${local.prefix}-workspace"
  resource_group_name         = var.azure_dbx_resource_group
  location                    = var.location
  sku                         = "premium"
  managed_resource_group_name = "${local.prefix}-workspace-managed-rg-${var.env}"
  tags                        = local.tags

  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = azurerm_virtual_network.azure_dbx_vnet.id
    private_subnet_name                                  = azurerm_subnet.azure_dbx_private_subnet.name
    public_subnet_name                                   = azurerm_subnet.azure_dbx_public_subnet.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private.id
  }
}

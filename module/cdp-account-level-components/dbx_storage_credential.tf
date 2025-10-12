resource "azurerm_databricks_access_connector" "cdp_access_connector" {
  name                = "cdp_access_connector-resource"
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }
}

resource "databricks_storage_credential" "cdp_storage_credential" {
#   provider       = databricks.dbx_workspace
#   depends_on     = [databricks_mws_permission_assignment.account_admin]
  name           = "cdp_storage_credential"
  isolation_mode = "ISOLATION_MODE_ISOLATED"
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.cdp_access_connector.id
  }
}
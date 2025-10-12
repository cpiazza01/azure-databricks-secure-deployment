resource "azurerm_storage_container" "cdp_catalog" {
  name               = "cdp-catalog"
  storage_account_id = data.azurerm_storage_account.cdpdatabrick.id
}

resource "azurerm_role_assignment" "container_access" {
  scope                = azurerm_storage_container.cdp_catalog.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.cdp_access_connector.identity.principal_id
}
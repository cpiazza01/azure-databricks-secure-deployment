resource "azurerm_databricks_access_connector" "cdp_access_connector" {
  name                = "cdp_access_connector-resource"
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "container_access" {
  scope                = azurerm_storage_container.cdp_catalog.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.cdp_access_connector.identity.principal_id
}

resource "databricks_storage_credential" "cdp_storage_credential" {
  name = "cdp_storage_credential"
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.cdp_access_connector.id
  }
}
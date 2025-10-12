resource "azurerm_databricks_access_connector" "cdp_access_connector" {
  name                = "cdp_access_connector-resource"
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }
}

resource "databricks_storage_credential" "cdp_storage_credential" {
  name           = "cdp_storage_credential"
  metastore_id   = data.databricks_metastore.eastus.id
  isolation_mode = "ISOLATION_MODE_ISOLATED"
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.cdp_access_connector.id
  }
}

resource "databricks_workspace_binding" "cdp_storage_credential_binding" {
  workspace_id    = local.workspace_id
  securable_name  = databricks_storage_credential.cdp_storage_credential.name
  securable_type  = "storage-credential"
  binding_type    = "BINDING_TYPE_READ_WRITE"
}
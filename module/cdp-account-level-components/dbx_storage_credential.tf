resource "azurerm_databricks_access_connector" "cdp_access_connector" {
  name                = "cdp_access_connector"
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }
}

resource "databricks_storage_credential" "cdp_storage_credential" {
  provider        = databricks.dbx_workspace
  depends_on      = [databricks_mws_permission_assignment.account_admin]
  name            = "cdp_storage_credential_${lower(var.env)}"
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  skip_validation = true
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.cdp_access_connector.id
  }
}

resource "databricks_grant" "workspace_admin_storage_credential_grant" {
  provider           = databricks.dbx_workspace
  depends_on         = [databricks_mws_permission_assignment.account_admin]
  storage_credential = databricks_storage_credential.cdp_storage_credential.id
  principal          = [for group in databricks_group.entra_group_workspace_admin_team : group][0].display_name
  privileges         = ["CREATE_EXTERNAL_LOCATION"]
}
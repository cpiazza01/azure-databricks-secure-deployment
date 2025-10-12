resource "databricks_grant" "workspace_admin_metastore_grants" {
  provider   = databricks.dbx_workspace
  metastore  = data.databricks_metastore.eastus.id
  principal  = local.workspace_admin_group.display_name
  privileges = [
    "CREATE_EXTERNAL_LOCATION",
    "CREATE_RECIPIENT", 
    "CREATE_PROVIDER",
    "CREATE_SHARE",
    "CREATE_CONNECTION",
    "CREATE_SERVICE_CREDENTIAL",
    "CREATE_FOREIGN_CATALOG",
    "CREATE_CATALOG"
  ]
}

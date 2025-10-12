resource "databricks_grant" "workspace_admin_metastore_grants" {
  provider   = databricks.dbx_workspace
  depends_on = [databricks_mws_permission_assignment.account_admin]
  metastore  = data.databricks_metastore.eastus.id
  principal  = local.workspace_admin_group.display_name
  privileges = [
    "CREATE_RECIPIENT",
    "CREATE_PROVIDER",
    "CREATE_SHARE",
    "CREATE_CONNECTION",
    "CREATE_SERVICE_CREDENTIAL",
    "CREATE_EXTERNAL_LOCATION",
    "CREATE_CATALOG"
  ]
}
resource "databricks_mws_permission_assignment" "catalog_users" {
  workspace_id = local.workspace_id
  principal_id = databricks_group.catalog_users.id
  permissions  = ["USER"]
  depends_on   = [databricks_metastore_assignment.this]
}

resource "databricks_mws_permission_assignment" "account_admin" {
  workspace_id = local.workspace_id
  principal_id = data.databricks_service_principal.account_admin_sp.id
  permissions  = ["ADMIN"]
  depends_on   = [databricks_metastore_assignment.this]
}

resource "databricks_mws_permission_assignment" "workspace_admins" {
  workspace_id = local.workspace_id
  principal_id = local.workspace_admin_group.id
  permissions  = ["ADMIN"]
  depends_on   = [databricks_metastore_assignment.this]
}
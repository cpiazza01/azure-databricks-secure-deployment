resource "databricks_mws_permission_assignment" "account_admin" {
  workspace_id = local.workspace_id
  principal_id = data.databricks_service_principal.account_admin_sp.id
  permissions  = ["ADMIN"]
  depends_on   = [databricks_metastore_assignment.this]
}

resource "databricks_mws_permission_assignment" "workspace_admins" {
  workspace_id = local.workspace_id
  principal_id = [for group in databricks_group.entra_group_workspace_admin_team : group][0].id
  permissions  = ["ADMIN"]
  depends_on   = [databricks_metastore_assignment.this]
}

# Access group workspace assignments
resource "databricks_mws_permission_assignment" "catalog_users_rw" {
  workspace_id = local.workspace_id
  principal_id = databricks_group.catalog_users_rw.id
  permissions  = ["USER"]
  depends_on   = [databricks_metastore_assignment.this]
}
resource "databricks_mws_permission_assignment" "catalog_users_ro" {
  workspace_id = local.workspace_id
  principal_id = databricks_group.catalog_users_ro.id
  permissions  = ["USER"]
  depends_on   = [databricks_metastore_assignment.this]
}
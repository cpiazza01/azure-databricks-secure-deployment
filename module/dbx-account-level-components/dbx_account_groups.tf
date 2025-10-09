resource "databricks_group" "entra_groups" {
  for_each     = data.azuread_group.databricks_groups
  display_name = each.value.display_name
  external_id  = each.value.object_id
}

resource "databricks_group" "catalog_users" {
  display_name = "DATABRICKS_CATALOG_USERS"
}

resource "databricks_group_member" "catalog_user_members" {
  for_each  = databricks_group.entra_groups
  group_id  = databricks_group.catalog_users.id
  member_id = each.value.id
}

resource "databricks_mws_permission_assignment" "catalog_users" {
  workspace_id = local.workspace_id
  principal_id = databricks_group.catalog_users.id
  permissions  = ["USER"]
}

resource "databricks_mws_permission_assignment" "workspace_admins" {
  workspace_id = local.workspace_id
  principal_id = local.workspace_admin_group.id
  permissions  = ["ADMIN"]
}
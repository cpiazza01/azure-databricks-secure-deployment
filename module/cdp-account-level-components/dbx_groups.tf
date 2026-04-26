resource "databricks_group" "catalog_users_rw" {
  display_name = "CDP_CATALOG_USERS_RW_${upper(var.env)}"
}
resource "databricks_entitlements" "catalog_users_rw_entitlements" {
  provider              = databricks.dbx_workspace
  depends_on            = [databricks_mws_permission_assignment.account_admin]
  group_id              = databricks_group.catalog_users_rw.id
  databricks_sql_access = true
  workspace_access      = true
}

resource "databricks_group" "catalog_users_ro" {
  display_name = "CDP_CATALOG_USERS_RO_${upper(var.env)}"
}
resource "databricks_entitlements" "catalog_users_ro_entitlements" {
  provider              = databricks.dbx_workspace
  depends_on            = [databricks_mws_permission_assignment.account_admin]
  group_id              = databricks_group.catalog_users_ro.id
  databricks_sql_access = true
  workspace_access      = true
}

resource "databricks_group" "entra_group_workspace_admin_team" {
  for_each     = { for k, v in data.azuread_group.databricks_groups : v.display_name => v if strcontains(v.display_name, "CDP_WORKSPACE_ADMIN_") }
  display_name = each.value.display_name
  external_id  = each.value.object_id
}
resource "databricks_group_member" "catalog_users_rw_entra_group_workspace_admin_team" {
  for_each  = databricks_group.entra_group_workspace_admin_team
  group_id  = databricks_group.catalog_users_rw.id
  member_id = each.value.id
}

resource "databricks_group" "entra_groups_project_teams" {
  for_each     = { for k, v in data.azuread_group.databricks_groups : v.display_name => v if strcontains(v.display_name, "CDP_PROJECT_TEAM_") }
  display_name = each.value.display_name
  external_id  = each.value.object_id
}
resource "databricks_group_member" "catalog_users_rw_entra_groups_project_teams" {
  for_each  = { for k, v in databricks_group.entra_groups_project_teams : v.display_name => v if upper(var.env) == "DEV" }
  group_id  = databricks_group.catalog_users_rw.id
  member_id = each.value.id
}
resource "databricks_group_member" "catalog_users_ro_entra_groups_project_teams" {
  for_each  = { for k, v in databricks_group.entra_groups_project_teams : v.display_name => v if contains(["TEST", "PROD"], upper(var.env)) }
  group_id  = databricks_group.catalog_users_ro.id
  member_id = each.value.id
}

resource "databricks_group" "entra_group_data_product_team" {
  for_each     = { for k, v in data.azuread_group.databricks_group : v.display_name => v if strcontains(v.display_name, "CDP_DATA_PRODUCT_TEAM_") }
  display_name = each.value.display_name
  external_id  = each.value.object_id
}
resource "databricks_group_member" "catalog_users_rw_entra_group_data_product_team" {
  for_each  = { for k, v in databricks_group.entra_group_data_product_team : v.display_name => v if upper(var.env) == "DEV" }
  group_id  = databricks_group.catalog_users_rw.id
  member_id = each.value.id
}
resource "databricks_group_member" "catalog_users_ro_entra_group_data_product_team" {
  for_each  = { for k, v in databricks_group.entra_group_data_product_team : v.display_name => v if contains(["TEST", "PROD"], upper(var.env)) }
  group_id  = databricks_group.catalog_users_ro.id
  member_id = each.value.id
}
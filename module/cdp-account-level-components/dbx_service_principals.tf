resource "databricks_service_principal" "workspace_admin_sp" {
  display_name = "SP_CDP_WORKSPACE_ADMIN_${upper(var.env)}"
}

resource "databricks_group_member" "workspace_admin_sp_in_admin_group" {
  group_id  = local.workspace_admin_group.id
  member_id = databricks_service_principal.workspace_admin_sp.id
}

resource "databricks_service_principal" "project_teams_rw_sps" {
  for_each     = databricks_group.entra_groups_project_teams
  display_name = "SP_RW_${each.value.display_name}"
}
resource "databricks_service_principal" "project_teams_ro_sps" {
  for_each     = databricks_group.entra_groups_project_teams
  display_name = "SP_RO_${each.value.display_name}"
}

resource "databricks_service_principal" "data_product_team_rw_sp" {
  for_each     = databricks_group.entra_groups_data_product_team
  display_name = "SP_RW_${each.value.display_name}"
}
resource "databricks_service_principal" "data_product_team_ro_sp" {
  for_each     = databricks_group.entra_groups_data_product_team
  display_name = "SP_RO_${each.value.display_name}"
}

resource "databricks_group_member" "catalog_users_rw_project_teams_rw_sps" {
  for_each  = databricks_service_principal.project_teams_rw
  group_id  = databricks_group.catalog_users_rw.id
  member_id = each.value.id
}
resource "databricks_group_member" "catalog_users_ro_project_teams_ro_sps" {
  for_each  = databricks_service_principal.project_teams_ro
  group_id  = databricks_group.catalog_users_ro.id
  member_id = each.value.id
}

resource "databricks_group_member" "catalog_users_rw_data_product_team_rw_sp" {
  for_each  = databricks_service_principal.data_product_team_rw
  group_id  = databricks_group.catalog_users_rw.id
  member_id = each.value.id
}
resource "databricks_group_member" "catalog_users_ro_data_product_team_ro_sp" {
  for_each  = databricks_service_principal.data_product_team_ro
  group_id  = databricks_group.catalog_users_ro.id
  member_id = each.value.id
}
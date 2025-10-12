resource "databricks_service_principal" "workspace_admin_sp" {
  display_name = "SP_CDP_WORKSPACE_ADMIN_${upper(var.env)}"
}

resource "databricks_group_member" "workspace_admin_sp_in_admin_group" {
  group_id  = local.workspace_admin_group.id
  member_id = databricks_service_principal.workspace_admin_sp.id
}

resource "databricks_service_principal" "rw" {
  for_each     = { for key, group in databricks_group.entra_groups : group.display_name => group if !strcontains(group.display_name, "WORKSPACE_ADMIN") }
  display_name = "SP_RW_${each.value.display_name}"
}

resource "databricks_service_principal" "ro" {
  for_each     = { for key, group in databricks_group.entra_groups : group.display_name => group if !strcontains(group.display_name, "WORKSPACE_ADMIN") }
  display_name = "SP_RO_${each.value.display_name}"
}

resource "databricks_group_member" "catalog_users_sps_rw" {
  for_each  = databricks_service_principal.rw
  group_id  = databricks_group.catalog_users.id
  member_id = each.value.id
}

resource "databricks_group_member" "catalog_users_sps_ro" {
  for_each  = databricks_service_principal.ro
  group_id  = databricks_group.catalog_users.id
  member_id = each.value.id
}
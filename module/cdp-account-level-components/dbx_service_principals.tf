resource "databricks_service_principal" "rw" {
  for_each     = databricks_group.entra_groups
  display_name = "SP_RW_${each.value.display_name}"
}

resource "databricks_service_principal" "ro" {
  for_each     = databricks_group.entra_groups
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
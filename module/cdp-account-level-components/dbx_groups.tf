resource "databricks_group" "entra_groups" {
  for_each     = data.azuread_group.databricks_groups
  display_name = each.value.display_name
  external_id  = each.value.object_id
}

resource "databricks_group" "catalog_users" {
  display_name = "CDP_CATALOG_USERS_${upper(var.env)}"
}

resource "databricks_group_member" "catalog_users_groups" {
  for_each  = databricks_group.entra_groups
  group_id  = databricks_group.catalog_users.id
  member_id = each.value.id
}
resource "databricks_group" "entra_groups" {
    for_each     = data.azuread_group.databricks_groups
    display_name = each.value.display_name
    external_id  = each.value.object_id
}
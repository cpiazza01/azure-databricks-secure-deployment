resource "databricks_group_member" "cdp_functions_group_membership_all_entra" {
  for_each  = local.cdp_entra_groups
  group_id  = local.cdp_functions_group.id
  member_id = each.value.id
}
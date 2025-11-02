resource "databricks_budget_policy" "budget_policies" {
  for_each    = databricks_group.entra_groups
  policy_name = "${each.value.display_name}_BUDGET_POLICY_${upper(var.env)}"
  custom_tags = [{
    key   = "Team"
    value = each.value.display_name
  }]
}

resource "databricks_access_control_rule_set" "domain_budget_policy_rule_set" {
  for_each = { for index, group in local.groups_with_budget_policies : group.display_name => group }
  name     = "accounts/${var.databricks_account_id}/budgetPolicies/${each.value.budget_policy_id}/ruleSets/default"

  grant_rules {
    principals = [each.value.acl_principal_id]
    role       = "roles/budgetPolicy.user"
  }
}
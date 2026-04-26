resource "databricks_budget_policy" "budget_policy_ws_admin" {
  policy_name           = "1_CDP_WORKSPACE_ADMIN_BUDGET_POLICY_${upper(var.env)}"
  binding_workspace_ids = [local.workspace_id]
  custom_tags = [{
    key   = "Team"
    value = "CDP_WORKSPACE_ADMIN"
  }]
}

resource "databricks_budget_policy" "budget_policies_project_teams" {
  for_each              = databricks_group.entra_groups_project_teams
  policy_name           = "${each.value.display_name}_BUDGET_POLICY_${upper(var.env)}"
  binding_workspace_ids = [local.workspace_id]
  custom_tags = [{
    key   = "Team"
    value = each.value.display_name
  }]
}
resource "databricks_access_control_rule_set" "domain_budget_policy_rule_set_project_teams" {
  for_each = { for index, group in local.groups_with_budget_policies_project_teams : group.display_name => group }
  name     = "accounts/${var.databricks_account_id}/budgetPolicies/${each.value.budget_policy_id}/ruleSets/default"

  grant_rules {
    principals = [each.value.acl_principal_id]
    role       = "roles/budgetPolicy.user"
  }
}

resource "databricks_budget_policy" "budget_policies_data_product_team" {
  for_each              = databricks_group.entra_group_data_product_team
  policy_name           = "${each.value.display_name}_BUDGET_POLICY_${upper(var.env)}"
  binding_workspace_ids = [local.workspace_id]
  custom_tags = [{
    key   = "Team"
    value = each.value.display_name
  }]
}
resource "databricks_access_control_rule_set" "domain_budget_policy_rule_set_data_product_team" {
  for_each = { for index, group in local.groups_with_budget_policies_data_product_team : group.display_name => group }
  name     = "accounts/${var.databricks_account_id}/budgetPolicies/${each.value.budget_policy_id}/ruleSets/default"

  grant_rules {
    principals = [each.value.acl_principal_id]
    role       = "roles/budgetPolicy.user"
  }
}
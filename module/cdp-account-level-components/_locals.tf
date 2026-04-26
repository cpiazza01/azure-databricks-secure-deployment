locals {
  current_module_path = path.module
  parent_folder_path  = dirname(local.current_module_path)
  module_name         = basename(local.parent_folder_path)

  workspace = data.terraform_remote_state.azurerm_components.outputs.azure_databricks_workspace

  workspace_id  = local.workspace.workspace_id
  workspace_url = local.workspace.workspace_url

  groups_with_budget_policies_project_teams = flatten([
    for group in databricks_group.entra_groups_project_teams : [
      for pol in databricks_budget_policy.budget_policies_project_teams :
      {
        display_name     = group.display_name
        acl_principal_id = group.acl_principal_id
        budget_policy_id = pol.policy_id
      }
      if group.display_name == split("_BUDGET_POLICY_", pol.policy_name)[0]
    ]
  ])
  groups_with_budget_policies_data_product_team = flatten([
    for group in databricks_group.entra_groups_data_product_team : [
      for pol in databricks_budget_policy.budget_policies_data_product_team :
      {
        display_name     = group.display_name
        acl_principal_id = group.acl_principal_id
        budget_policy_id = pol.policy_id
      }
      if group.display_name == split("_BUDGET_POLICY_", pol.policy_name)[0]
    ]
  ])
}

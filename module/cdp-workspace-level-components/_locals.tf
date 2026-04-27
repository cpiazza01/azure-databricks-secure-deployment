locals {
  current_module_path = path.module
  parent_folder_path  = dirname(local.current_module_path)
  module_name         = basename(local.parent_folder_path)

  workspace = data.terraform_remote_state.azurerm_components.outputs.azure_databricks_workspace

  cdp_access_connector              = data.terraform_remote_state.cdp_account_components.outputs.cdp_access_connector
  cdp_storage_credential            = data.terraform_remote_state.cdp_account_components.outputs.cdp_storage_credential
  cdp_catalog_users_rw_group        = data.terraform_remote_state.cdp_account_components.outputs.cdp_catalog_users_rw_group
  cdp_catalog_users_ro_group        = data.terraform_remote_state.cdp_account_components.outputs.cdp_catalog_users_ro_group
  cdp_entra_group_workspace_admin   = data.terraform_remote_state.cdp_account_components.outputs.cdp_entra_group_workspace_admin
  cdp_entra_groups_project_teams    = data.terraform_remote_state.cdp_account_components.outputs.cdp_entra_groups_project_teams
  cdp_entra_group_data_product_team = data.terraform_remote_state.cdp_account_components.outputs.cdp_entra_group_data_product_team
  cdp_workspace_admin_sp            = data.terraform_remote_state.cdp_account_components.outputs.cdp_workspace_admin_sp

  cdp_project_teams_rw_sps     = data.terraform_remote_state.cdp_account_components.outputs.cdp_project_teams_rw_sps
  cdp_project_teams_ro_sps     = data.terraform_remote_state.cdp_account_components.outputs.cdp_project_teams_ro_sps
  cdp_data_product_team_rw_sps = data.terraform_remote_state.cdp_account_components.outputs.cdp_data_product_team_rw_sps
  cdp_data_product_team_ro_sps = data.terraform_remote_state.cdp_account_components.outputs.cdp_data_product_team_ro_sps

  workspace_id  = local.workspace.workspace_id
  workspace_url = local.workspace.workspace_url

  schema_grant_project_team_mappings_init = flatten([
    for group in local.cdp_entra_groups_project_teams : [
      for sp_rw in local.cdp_project_teams_rw_sps :
      {
        project_name       = split("_${upper(var.env)}", split("_TEAM_", group.display_name)[1])[0]
        group_display_name = group.display_name
        sp_rw_display_name = sp_rw.display_name
        sp_rw_app_id       = sp_rw.application_id
        sp_rw_id           = sp_rw.id
      }
      if split("_${upper(var.env)}", split("_TEAM_", group.display_name)[1])[0] == split("_${upper(var.env)}", split("_TEAM_", sp_rw.display_name)[1])[0]
    ]
  ])
  schema_grant_project_team_mappings = flatten([
    for config in local.schema_grant_project_team_mappings_init : [
      for sp_ro in local.cdp_project_teams_ro_sps :
      {
        project_name       = config.project_name
        group_display_name = config.group_display_name
        sp_rw_display_name = config.sp_rw_display_name
        sp_rw_app_id       = config.sp_rw_app_id
        sp_rw_id           = config.sp_rw_id
        sp_ro_display_name = sp_ro.display_name
        sp_ro_app_id       = sp_ro.application_id
        sp_ro_id           = sp_ro.id
      }
      if config.project_name == split("_${upper(var.env)}", split("_TEAM_", sp_ro.display_name)[1])[0]
    ]
  ])
}

output "schema_grant_project_team_mappings_init" {
  value = local.schema_grant_project_team_mappings_init
}
output "schema_grant_project_team_mappings" {
  value = local.schema_grant_project_team_mappings
}
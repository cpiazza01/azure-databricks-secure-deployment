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

  cdp_project_teams_rw_sps    = data.terraform_remote_state.cdp_account_components.outputs.cdp_project_teams_rw_sps
  cdp_project_teams_ro_sps    = data.terraform_remote_state.cdp_account_components.outputs.cdp_project_teams_ro_sps
  cdp_data_product_team_rw_sp = data.terraform_remote_state.cdp_account_components.outputs.cdp_data_product_team_rw_sp
  cdp_data_product_team_ro_sp = data.terraform_remote_state.cdp_account_components.outputs.cdp_data_product_team_ro_sp

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

  service_credential_configs = [
    {
      project_name = "EXAMPLE_CLAIMS_ENGINE"
      role_mappings = [
        {
          role_name   = "Storage Blob Data Contributor"
          resource_id = data.azurerm_storage_account.cpexamplestorageaccount.id
        },
        {
          role_name   = "Storage Account Contributor"
          resource_id = data.azurerm_storage_account.cpexamplestorageaccount.id
        }
      ]
    },
    {
      project_name = "EXAMPLE_PROVIDER_SOURCE"
      role_mappings = [
        {
          role_name   = "Storage Blob Data Contributor"
          resource_id = data.azurerm_storage_account.cpexamplestorageaccount.id
        },
      ]
    },
  ]
  service_credential_configs_flattened = flatten([
    for config in local.service_credential_configs : [
      for mapping in config.role_mappings : {
        project_name = config.project_name
        role_name    = mapping.role_name
        resource_id  = mapping.resource_id
      }
    ]
  ])
  access_connector_service_credential_config_mappings = flatten([
    for config in local.service_credential_configs_flattened : [
      for connector in azurerm_databricks_access_connector.cdp_service_credential_access_connectors :
      {
        project_name                  = config.project_name
        role_name                     = config.role_name
        resource_id                   = config.resource_id
        access_connector_id           = connector.id
        access_connector_principal_id = connector.identity[0].principal_id
      }
      if connector.tags.project_name == config.project_name
    ]
  ])
  service_credential_to_group_mappings_project_teams = flatten([
    for config in local.schema_grant_project_team_mappings : [
      for cred in databricks_credential.cdp_service_credentials :
      {
        project_name            = config.project_name
        group_display_name      = config.group_display_name
        sp_rw_display_name      = config.sp_rw_display_name
        sp_rw_app_id            = config.sp_rw_app_id
        sp_rw_id                = config.sp_rw_id
        sp_ro_display_name      = config.sp_ro_display_name
        sp_ro_app_id            = config.sp_ro_app_id
        sp_ro_id                = config.sp_ro_id
        service_credential_id   = cred.id
        service_credential_name = cred.name
      }
      if config.project_name == split("_${lower(var.env)}", split("cdp_service_credential_", cred.name)[1])[0]
    ]
  ])
  # service_credential_to_group_mappings_data_product_team = [
  #   for config in local.schema_grant_project_team_mappings : 
  #     {
  #       project_name            = config.project_name
  #       group_display_name      = config.group_display_name
  #       sp_rw_display_name      = config.sp_rw_display_name
  #       sp_rw_app_id            = config.sp_rw_app_id
  #       sp_rw_id                = config.sp_rw_id
  #       sp_ro_display_name      = config.sp_ro_display_name
  #       sp_ro_app_id            = config.sp_ro_app_id
  #       sp_ro_id                = config.sp_ro_id
  #       service_credential_id   = cred.id
  #       service_credential_name = cred.name
  #     }
  #   ]
}

output "access_connector_service_credential_config_mappings" {
  value = local.access_connector_service_credential_config_mappings
}
output "service_credential_to_group_mappings" {
  value = local.service_credential_to_group_mappings
}
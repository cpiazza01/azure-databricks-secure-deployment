locals {
  current_module_path = path.module
  parent_folder_path  = dirname(local.current_module_path)
  module_name         = basename(local.parent_folder_path)

  workspace = data.terraform_remote_state.azurerm_components.outputs.azure_databricks_workspace

  cdp_access_connector       = data.terraform_remote_state.cdp_account_components.outputs.cdp_access_connector
  cdp_storage_credential     = data.terraform_remote_state.cdp_account_components.outputs.cdp_storage_credential
  cdp_catalog_users_group    = data.terraform_remote_state.cdp_account_components.outputs.cdp_catalog_users_group
  cdp_entra_groups           = data.terraform_remote_state.cdp_account_components.outputs.cdp_entra_groups
  cdp_bronze_rw_group        = data.terraform_remote_state.cdp_account_components.outputs.cdp_bronze_rw_group
  cdp_bronze_ro_group        = data.terraform_remote_state.cdp_account_components.outputs.cdp_bronze_ro_group
  cdp_silver_rw_group        = data.terraform_remote_state.cdp_account_components.outputs.cdp_silver_rw_group
  cdp_silver_ro_group        = data.terraform_remote_state.cdp_account_components.outputs.cdp_silver_ro_group
  cdp_gold_rw_group          = data.terraform_remote_state.cdp_account_components.outputs.cdp_gold_rw_group
  cdp_gold_ro_group          = data.terraform_remote_state.cdp_account_components.outputs.cdp_gold_ro_group
  cdp_staging_inbound_group  = data.terraform_remote_state.cdp_account_components.outputs.cdp_staging_inbound_group
  cdp_staging_outbound_group = data.terraform_remote_state.cdp_account_components.outputs.cdp_staging_outbound_group
  cdp_functions_group        = data.terraform_remote_state.cdp_account_components.outputs.cdp_functions_group

  cdp_rw_sps = data.terraform_remote_state.cdp_account_components.outputs.cdp_rw_sps
  cdp_ro_sps = data.terraform_remote_state.cdp_account_components.outputs.cdp_ro_sps

  workspace_id             = local.workspace.workspace_id
  workspace_url            = local.workspace.workspace_url
  workspace_admin_group    = [for group in local.cdp_entra_groups : group if group.display_name == "CDP_WORKSPACE_ADMIN_${upper(var.env)}"][0]
  platform_ingestion_group = [for group in local.cdp_entra_groups : group if group.display_name == "CDP_PLATFORM_TEAM_INGESTION_${upper(var.env)}"][0]
  platform_conformed_group = [for group in local.cdp_entra_groups : group if group.display_name == "CDP_PLATFORM_TEAM_CONFORMED_${upper(var.env)}"][0]
  analytics_team_groups    = [for group in local.cdp_entra_groups : group if startswith(group.display_name, "CDP_ANALYTICS_TEAM_")]
  app_team_groups          = [for group in local.cdp_entra_groups : group if startswith(group.display_name, "CDP_APP_TEAM_")]
  consumer_team_groups     = [for group in local.cdp_entra_groups : group if startswith(group.display_name, "CDP_CONSUMER_TEAM_")]

  platform_ingestion_sp_rw = [for sp in local.cdp_rw_sps : sp if sp.display_name == "SP_RW_CDP_PLATFORM_TEAM_INGESTION_${upper(var.env)}"][0]
  platform_ingestion_sp_ro = [for sp in local.cdp_ro_sps : sp if sp.display_name == "SP_RO_CDP_PLATFORM_TEAM_INGESTION_${upper(var.env)}"][0]
  platform_conformed_sp_rw = [for sp in local.cdp_rw_sps : sp if sp.display_name == "SP_RW_CDP_PLATFORM_TEAM_CONFORMED_${upper(var.env)}"][0]
  platform_conformed_sp_ro = [for sp in local.cdp_ro_sps : sp if sp.display_name == "SP_RO_CDP_PLATFORM_TEAM_CONFORMED_${upper(var.env)}"][0]
  analytics_team_sps_rw    = [for sp in local.cdp_rw_sps : sp if startswith(sp.display_name, "SP_RW_CDP_ANALYTICS_TEAM_")]
  analytics_team_sps_ro    = [for sp in local.cdp_ro_sps : sp if startswith(sp.display_name, "SP_RO_CDP_ANALYTICS_TEAM_")]
  app_team_sps_rw          = [for sp in local.cdp_rw_sps : sp if startswith(sp.display_name, "SP_RW_CDP_APP_TEAM_")]
  app_team_sps_ro          = [for sp in local.cdp_ro_sps : sp if startswith(sp.display_name, "SP_RO_CDP_APP_TEAM_")]
  consumer_team_sps_rw     = [for sp in local.cdp_rw_sps : sp if startswith(sp.display_name, "SP_RW_CDP_CONSUMER_TEAM_")]
  consumer_team_sps_ro     = [for sp in local.cdp_ro_sps : sp if startswith(sp.display_name, "SP_RO_CDP_CONSUMER_TEAM_")]

}

locals {
  current_module_path = path.module
  parent_folder_path  = dirname(local.current_module_path)
  module_name         = basename(local.parent_folder_path)

  workspace = data.terraform_remote_state.azurerm_components.outputs.azure_databricks_workspace

  workspace_id             = local.workspace.workspace_id
  workspace_url            = local.workspace.workspace_url
  workspace_admin_group    = [for group in databricks_group.entra_groups : group if group.display_name == "CDP_WORKSPACE_ADMIN_${upper(var.env)}"][0]
  platform_ingestion_group = [for group in databricks_group.entra_groups : group if group.display_name == "CDP_PLATFORM_TEAM_INGESTION_${upper(var.env)}"][0]
  platform_conformed_group = [for group in databricks_group.entra_groups : group if group.display_name == "CDP_PLATFORM_TEAM_CONFORMED_${upper(var.env)}"][0]
  analytics_team_groups    = [for group in databricks_group.entra_groups : group if startswith(group.display_name, "CDP_ANALYTICS_TEAM_")]
  app_team_groups          = [for group in databricks_group.entra_groups : group if startswith(group.display_name, "CDP_APP_TEAM_")]
  consumer_team_groups     = [for group in databricks_group.entra_groups : group if startswith(group.display_name, "CDP_CONSUMER_TEAM_")]

  platform_ingestion_sp_rw = [for sp in databricks_service_principal.rw : sp if sp.display_name == "SP_RW_CDP_PLATFORM_TEAM_INGESTION_${upper(var.env)}"][0]
  platform_ingestion_sp_ro = [for sp in databricks_service_principal.ro : sp if sp.display_name == "SP_RO_CDP_PLATFORM_TEAM_INGESTION_${upper(var.env)}"][0]
  platform_conformed_sp_rw = [for sp in databricks_service_principal.rw : sp if sp.display_name == "SP_RW_CDP_PLATFORM_TEAM_CONFORMED_${upper(var.env)}"][0]
  platform_conformed_sp_ro = [for sp in databricks_service_principal.ro : sp if sp.display_name == "SP_RO_CDP_PLATFORM_TEAM_CONFORMED_${upper(var.env)}"][0]
  analytics_team_sps_rw    = [for sp in databricks_service_principal.rw : sp if startswith(sp.display_name, "SP_RW_CDP_ANALYTICS_TEAM_")]
  analytics_team_sps_ro    = [for sp in databricks_service_principal.ro : sp if startswith(sp.display_name, "SP_RO_CDP_ANALYTICS_TEAM_")]
  app_team_sps_rw          = [for sp in databricks_service_principal.rw : sp if startswith(sp.display_name, "SP_RW_CDP_APP_TEAM_")]
  app_team_sps_ro          = [for sp in databricks_service_principal.ro : sp if startswith(sp.display_name, "SP_RO_CDP_APP_TEAM_")]
  consumer_team_sps_rw     = [for sp in databricks_service_principal.rw : sp if startswith(sp.display_name, "SP_RW_CDP_CONSUMER_TEAM_")]
  consumer_team_sps_ro     = [for sp in databricks_service_principal.ro : sp if startswith(sp.display_name, "SP_RO_CDP_CONSUMER_TEAM_")]
}

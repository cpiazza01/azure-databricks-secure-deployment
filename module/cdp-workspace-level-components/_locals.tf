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
  cdp_functions_ro_group     = data.terraform_remote_state.cdp_account_components.outputs.cdp_functions_ro_group
  cdp_functions_rw_group     = data.terraform_remote_state.cdp_account_components.outputs.cdp_functions_rw_group
  cdp_audit_ro_group         = data.terraform_remote_state.cdp_account_components.outputs.cdp_audit_ro_group
  cdp_audit_rw_group         = data.terraform_remote_state.cdp_account_components.outputs.cdp_audit_rw_group
  cdp_workspace_admin_sp     = data.terraform_remote_state.cdp_account_components.outputs.cdp_workspace_admin_sp


  cdp_rw_sps = data.terraform_remote_state.cdp_account_components.outputs.cdp_rw_sps
  cdp_ro_sps = data.terraform_remote_state.cdp_account_components.outputs.cdp_ro_sps

  workspace_id          = local.workspace.workspace_id
  workspace_url         = local.workspace.workspace_url
  workspace_admin_group = [for group in local.cdp_entra_groups : group if group.display_name == "CDP_WORKSPACE_ADMIN_${upper(var.env)}"][0]

  groups_and_sps_with_schema = {
    for index, ro_sp in local.cdp_ro_sps: replace(ro_sp.display_name, "SP_RO_", "") => [
      for rw_sp in local.cdp_rw_sps : 
      {
        ro_sp_display_name   = ro_sp.display_name
        ro_sp_application_id = ro_sp.application_id
        rw_sp_display_name   = rw_sp.display_name
        rw_sp_application_id = rw_sp.application_id
        group_display_name   = replace(ro_sp.display_name, "SP_RO_", "")
        schema_prefix        = lower(trimsuffix(trimprefix(ro_sp.display_name, "SP_RO_CDP_"), "_${upper(var.env)}"))

      }
      if replace(ro_sp.display_name, "SP_RO_CDP_", "SP_RW_CDP_") == rw_sp.display_name
    ]
  }
}

output "groups_and_sps_with_schema" {
  value = local.groups_and_sps_with_schema
}
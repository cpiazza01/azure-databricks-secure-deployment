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
}

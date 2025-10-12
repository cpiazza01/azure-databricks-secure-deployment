locals {
  current_module_path = path.module
  parent_folder_path  = dirname(local.current_module_path)
  module_name         = basename(local.parent_folder_path)

  workspace = data.terraform_remote_state.azurerm_components.outputs.azure_databricks_workspace

  cdp_access_connector   = data.terraform_remote_state.cdp_account_components.outputs.cdp_access_connector
  cdp_storage_credential = data.terraform_remote_state.cdp_account_components.outputs.cdp_storage_credential

  workspace_id  = local.workspace.workspace_id
  workspace_url = local.workspace.workspace_url
}

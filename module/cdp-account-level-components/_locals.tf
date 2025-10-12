locals {
  current_module_path = path.module
  parent_folder_path  = dirname(local.current_module_path)
  module_name         = basename(local.parent_folder_path)

  workspace = data.terraform_remote_state.azurerm_components.outputs.azure_databricks_workspace

  workspace_id          = local.workspace.workspace_id
  workspace_url         = local.workspace.workspace_url
  workspace_admin_group = [for group in databricks_group.entra_groups : group if group.display_name == "CDP_WORKSPACE_ADMIN_DEV"][0]
}

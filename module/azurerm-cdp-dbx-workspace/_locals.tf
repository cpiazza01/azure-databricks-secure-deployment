locals {
  current_module_path = path.module
  parent_folder_path  = dirname(local.current_module_path)
  module_name         = basename(local.parent_folder_path)

  prefix           = "cdp-azure-databricks"
  dbfsname_transit = "cdpdbfstransit"
  dbfsname_app     = "cdpdbfsapp"

  tags = {
    Environment = var.env
    Owner       = data.azuread_service_principal.current_user.display_name
  }
}

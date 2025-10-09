locals {
  current_module_path = path.module
  parent_folder_path  = dirname(local.current_module_path)
  module_name         = basename(local.parent_folder_path)

  prefix           = "cpiazza-azure-databricks"
  dbfsname_transit = "cpiazzadbfstransit"
  dbfsname_app     = "cpiazzadbfsapp"

  tags = {
    Environment = var.env
    Owner       = data.azuread_service_principal.current_user.display_name
  }
}

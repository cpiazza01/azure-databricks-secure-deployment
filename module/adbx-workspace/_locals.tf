locals {
  current_module_path = path.module
  parent_folder_path  = dirname(local.current_module_path)
  module_name         = basename(local.parent_folder_path)

  prefix           = "cpiazza-azure-databricks"
  dbfsname_transit = "${local.prefix}-dbfs-transit"
  dbfsname_app     = "${local.prefix}-dbfs-app"

  tags = {
    Environment = var.env
    Owner       = data.azuread_service_principal.current_user.display_name
  }
}
locals {
  current_module_path = path.module
  parent_folder_path  = dirname(local.current_module_path)
  module_name         = basename(local.parent_folder_path)

  prefix   = "cpiazza-azure-databricks"
  dbfsname = join("", ["dbfs", "${random_string.naming.result}"])
  tags = {
    Environment = var.env
    Owner       = lookup(data.external.me.result, "name")
  }
}
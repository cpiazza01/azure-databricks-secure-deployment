variable "env" {
  type    = string
  default = "prod"
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "East US"
}

variable "workspace_admin_client_id" {
  type = string
}

variable "storage_account_acceses_to_grant" {
  type = list(string)
  default = [
    "Storage Account Contributor",
    "Storage Blob Data Contributor",
    # "Storage Queue Data Contributor",
    "EventGrid EventSubscription Contributor"
  ]
}

variable "cdp_bronze_and_silver_schemas" {
  type = list(string)
  default = [
    "cms"
  ]
}

variable "cdp_gold_schemas" {
  type = list(string)
  default = [
    "claim",
    "provider",
    "member",
    "benefits",
    "sales"
  ]
}

variable "cdp_catalog_privileges" {
  type    = list(string)
  default = ["USE_CATALOG", "USE_SCHEMA", "BROWSE"]
}

variable "cdp_ro_privileges_table_schemas" {
  type    = list(string)
  default = ["SELECT"]
}

variable "cdp_rw_privileges_table_schemas" {
  type    = list(string)
  default = ["SELECT", "CREATE_TABLE", "CREATE_VOLUME"]
}

variable "cdp_privileges_functions_schema" {
  type    = list(string)
  default = ["CREATE_FUNCTION"]
}

variable "cdp_privileges_staging" {
  type    = list(string)
  default = ["CREATE_EXTERNAL_VOLUME", "CREATE_EXTERNAL_TABLE"]
}
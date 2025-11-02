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

variable "cdp_privileges_functions_schema_rw" {
  type    = list(string)
  default = ["CREATE_FUNCTION", "EXECUTE"]
}

variable "cdp_privileges_functions_schema_ro" {
  type    = list(string)
  default = ["EXECUTE"]
}

variable "cdp_privileges_staging" {
  type    = list(string)
  default = ["CREATE_EXTERNAL_VOLUME", "CREATE_EXTERNAL_TABLE"]
}

variable "cluster_policy_node_types_engineers" {
  type = list(string)
  default = [
    "Standard_D4pds_v6",
    "Standard_E8_v3",
    "Standard_L8s_v2"
  ]
}

variable "cluster_policy_node_types_analytics" {
  type = list(string)
  default = [
    "Standard_D4pds_v6",
    "Standard_D8pds_v6",
    "Standard_D16pds_v6",
    "Standard_D32pds_v6",
    "Standard_E8_v3",
    "Standard_E16_v3",
    "Standard_E32_v3",
    "Standard_E64_v3",
    "Standard_L8s_v2",
    "Standard_L16s_v2",
    "Standard_L32s_v2",
    "Standard_L64s_v2",
    "Standard_NC4as_T4_v3",
    "Standard_NC8as_T4_v3",
    "Standard_NC16as_T4_v3"
  ]
}
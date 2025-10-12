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
    "Storage Queue Data Contributor",
    "EventGrid EventSubscription Contributor"
  ]
}
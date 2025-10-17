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

variable "databricks_account_id" {
  type    = string
  default = "946e76c0-2fb6-426d-aa32-e75c629076f0"
}

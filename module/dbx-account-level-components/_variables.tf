variable "env" {
  type    = string
  default = "prod"
}

variable "azure_dbx_resource_group" {
  type    = string
  default = "azure-databricks-rg"
}

variable "location" {
  type    = string
  default = "East US"
}

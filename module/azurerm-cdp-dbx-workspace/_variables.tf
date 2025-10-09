variable "env" {
  type = string
}

variable "azure_dbx_vnet_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "East US"
}

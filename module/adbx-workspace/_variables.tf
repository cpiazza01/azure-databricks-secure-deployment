variable "env" {
  type    = string
  default = "prod"
}

variable "cidr_transit" {
  type    = string
  default = "10.0.0.0/24"
}

variable "cidr_dp" {
  type    = string
  default = "11.0.0.0/24"
}

variable "rg_transit" {
  type    = string
  default = "azure-databricks-rg"
}

variable "rg_dp" {
  type    = string
  default = "azure-databricks-rg"
}

variable "location" {
  type    = string
  default = "East US"
}
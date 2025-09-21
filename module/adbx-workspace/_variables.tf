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

variable "location" {
  type    = string
  default = "East US"
}

variable "transit_private_subnet_endpoints" {
  default = []
}

variable "private_subnet_endpoints" {
  default = []
}
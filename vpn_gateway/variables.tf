variable "application_name" {}
variable "environment" {}
variable "location" {}
variable "resource_group" {}
variable "vnet" {}

variable "vng_address_prefix"{
  default = "10.10.50.0/28"
}

variable "vpn_client_address_space" {
  type    = "list"
  default = ["10.20.50.0/24"]
}

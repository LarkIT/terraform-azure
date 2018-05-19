variable "application_name" {}
variable "environment" {}
variable "location" {}
variable "vnet_rg_name" {}
variable "vnet_name" {}

variable "agw_size" {
  default = "Standard_Small"
}
variable "tier" {
  default = "Standard"
}

variable "capacity" {
  default = 2
}

variable "ip_address_list" {
  type = list
}

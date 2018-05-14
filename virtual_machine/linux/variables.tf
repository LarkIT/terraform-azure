variable "rg" {}
variable "location" {}
variable "environment" {}
variable "application_name" {}
variable "subnet_id" {}
variable "hostname" {}
variable "ssh_public_key" {}
variable "security_group" {}

variable "admin_username" {
  default = "azure"
}

variable "number_servers" {
  default = "1"
}

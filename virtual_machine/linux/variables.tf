variable "resource_group" {}
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

variable "managed_disk_type" {
  default = "Premium_LRS"
}

variable "vm_size" {
  default = "Standard_DS1_v2"
}

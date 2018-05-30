variable "resource_group" {}
variable "location" {}
variable "environment" {}
variable "application_name" {}
variable "subnet_id" {}
variable "hostname" {}
variable "admin_password" {}
variable "security_group" {}

variable "admin_username" {
  default = "azure"
}

variable "number_servers" {
  default = "1"
}

variable "os_disk_size" {
  default = "128"
}

variable "managed_disk_type" {
  default = "Premium_LRS"
}

variable "vm_size" {
  default = "Standard_DS1_v2"
}

variable "public_ip_allocation" {
  default = "dynamic"
}

variable "start_index" {
  default = "0"
}

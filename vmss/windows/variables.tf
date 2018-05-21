variable "resource_group" {}
variable "location" {}
variable "environment" {}
variable "application_name" {}
variable "subnet_id" {}
variable "admin_password" {}
variable "cluster_ip" {}

variable "admin_username" {
  default = "azure"
} 

variable "vmss_size" {
  default = "Standard_A0"
}

variable "tier" {
  default = "Standard"
}

variable "capacity" {
  default = "2"
}

variable "tags" {
  default = {
    builtby = "Terraform"
  }
}

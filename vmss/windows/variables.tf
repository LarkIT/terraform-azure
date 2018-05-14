variable "resource_group" {}
variable "location" {}
variable "environment" {}
variable "application_name" {}
variable "subnet_id" {}
variable "admin_password" {}

variable "admin_username" {
  default = "azure"
} 

variable "tags" {
  default = {
    builtby = "Terraform"
  }
}

variable "resource_group" {}
variable "location" {}
variable "environment" {}
variable "application_name" {}
variable "file_share_name" {}

variable "account_tier" {
  default = "Standard"
}

variable "account_replication_type" {
  default = "LRS"
}

variable "quota" {
  default = "5"
}

variable "tags" {
  default = {
    builtby = "Terraform"
  }
}

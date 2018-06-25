variable "resource_group" {}
variable "location" {}
variable "environment" {}
variable "application_name" {}
variable "subnet_id" {}
variable "hostname" {}
variable "admin_password" {}
variable "security_group" {}
variable "server_type" {}

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

variable "nic_ip_allocation" {
  default = "dynamic"
}

variable "private_ip_address" {
  default = ""
}

variable "start_index" {
  default = 0
}

variable "storage_image_reference" {
  default = {
    sql_server = {
      publisher = "MicrosoftSQLServer"
      offer     = "SQL2017-WS2016"
      sku       = "Standard"
      version   = "latest"
    }
    windows_server = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    }
  }
}

variable "additional_nics" {
  type    = "list"
  default = []
}

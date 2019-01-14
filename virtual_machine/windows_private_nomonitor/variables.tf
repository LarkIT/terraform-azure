variable "resource_group" {}
variable "location" {}
variable "environment" {}
variable "application_name" {}
variable "subnet_id" {}
variable "hostname" {}
variable "admin_password" {}
variable "security_group" {}
variable "server_type" {}
variable "support_email" {}

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
    sql_server_dev = {
      publisher = "MicrosoftSQLServer"
      offer     = "SQL2017-WS2016"
      sku       = "SQLDEV"
      version   = "latest"
    }
    sql_server_2008 = {
      publisher = "MicrosoftSQLServer"
      offer     = "SQL2008R2SP3-WS2008R2SP1"
      sku       = "Standard"
      version   = "latest"
    }
    sql_server_2008_express = {
      publisher = "MicrosoftSQLServer"
      offer     = "SQL2008R2SP3-WS2008R2SP1"
      sku       = "Express"
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

variable "cpu_threshold" {
  default = "90"
}

variable "memory_threshold" {
  default = "10"
}

variable "diskusage_threshold" {
  default = "10"
}

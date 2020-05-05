variable "resource_group" {}
variable "location" {}
variable "environment" {}
variable "application_name" {}
variable "subnet_id" {}
variable "hostname" {}
variable "ssh_public_key" {}
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

variable "storage_image_reference" {
  default = {
    centos_server = {    
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7.5"
      version   = "latest"
    }
    ubuntu_server = {    
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "16.04.0-LTS"
      version   = "latest"
    }
    ubuntu18 = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
  }
}

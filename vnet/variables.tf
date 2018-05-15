variable "application_name" {}
variable "environment" {}
variable "location" {}
variable "resource_group_name" {
  default = ""
}

variable "address_space" {
  default = "10.10.0.0/16"
}

variable "test_network" {
  description = "Subnet layout for network zones"

  default = {
    test_dmz = "10.10.0.0/24"
    test_app = "10.10.10.0/24"
    test_db  = "10.10.20.0/24"
  }
}

variable "network" {
  description = "Subnet layout for network zones"

  default = {
    test = {
      dmz = "10.10.0.0/24"
      app = "10.10.10.0/24"
      db  = "10.10.20.0/24"
    } 
    prod = {
      dmz = "10.10.100.0/24"
      app = "10.10.110.0/24"
      db  = "10.10.120.0/24"
    }
  }
}

variable "dns_servers" {
  default = ["10.10.0.7", "10.10.0.8"]
}

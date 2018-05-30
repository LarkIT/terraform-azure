variable "application_name" {}
variable "environment" {}
variable "location" {}

variable "address_space" {
  default = "10.10.0.0/16"
}

variable "network" {
  description = "Subnet layout for network zones"

  default = {
    test = {
      dmz    = "10.10.0.0/24"
      app    = "10.10.10.0/24"
      db     = "10.10.20.0/24"
      domain = "10.10.30.0/24"
      agw    = "10.10.40.0/24"
    }
    dev = {
      dmz    = "10.10.200.0/24"
      app    = "10.10.210.0/24"
      db     = "10.10.220.0/24"
      domain = "10.10.230.0/24"
      agw    = "10.10.240.0/24"
    }

    prod = {
      dmz    = "10.10.100.0/24"
      app    = "10.10.110.0/24"
      db     = "10.10.120.0/24"
      domain = "10.10.130.0/24"
      agw    = "10.10.140.0/24"
    }
  }
}

variable "dns_servers" {
  default = ["10.10.0.7", "10.10.0.8"]
}

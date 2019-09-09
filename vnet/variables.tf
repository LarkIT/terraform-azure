variable "application_name" {}
variable "environment" {}
variable "location" {}

variable "address_space" {
  default = ["10.40.0.0/16"]
}

variable "network" {
  description = "Subnet layout for network zones"

  default = {
    test = {
      dmz    = "10.10.0.0/24"
      app    = "10.10.10.0/24"
      db     = "10.10.20.0/24"
      #domain = "10.10.30.0/24"
      #agw    = "10.10.40.0/24"
      dbinst = "10.10.60.0/24"
    }
    stage = {
      dmz    = "10.40.100.0/24"
      app    = "10.40.110.0/24"
      db     = "10.40.120.0/24"
      dbinst = "10.40.130.0/24"
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
  default = ["10.10.130.4", "10.10.130.5"]
}

variable "location" {}

variable "environment" {}

variable "resource_group" {}

variable "application_name" {}

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
      dmz    = "10.10.90.0/24"
      app    = "10.10.91.0/24"
      db     = "10.10.92.0/24"
      #domain = "10.10.93.0/24"
      #agw    = "10.10.94.0/24"
      dbinst = "10.10.95.0/24"
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

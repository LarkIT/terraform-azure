variable "db_name" {
  description = "The name of the resource group in which to create the virtual network."
  default = "sqldb"
}
variable "db_server_name" {
  description = "The name of the resource group in which to create the virtual network."
  default = "sqlserver"
}
variable "resource_group" {
  description = "The name of the resource group in which to create the SQL Server and DB."
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "westus"
}

variable "sql_admin" {
  description = "The administrator username of the SQL Server."
}

variable "sql_password" {
  description = "The administrator password of the SQL Server."
}

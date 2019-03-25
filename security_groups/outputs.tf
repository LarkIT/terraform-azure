output "windows_id" {
  value = "${azurerm_network_security_group.windows.id}"
}

output "sql_managed_instance_id" {
  value = "${azurerm_network_security_group.sql_managed_instance.id}"
}

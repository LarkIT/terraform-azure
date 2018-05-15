output "rg_name" {
  value = "${local.resource_group}"
}

output "dmz_subnet_id" {
  value = "${azurerm_subnet.test_dmz_subnet.id}"
}

output "app_subnet_id" {
  value = "${azurerm_subnet.test_app_subnet.id}"
}

output "db_subnet_id" {
  value = "${azurerm_subnet.test_db_subnet.id}"
}

output "location" {
  value = "${var.location}"
}

output "environment" {
  value = "${var.environment}"
}

output "rg_name" {
  value = "${local.resource_group}"
}

output "dmz_subnet_id" {
  value = "${azurerm_subnet.dmz_subnet.id}"
}

output "app_subnet_id" {
  value = "${azurerm_subnet.app_subnet.id}"
}

output "db_subnet_id" {
  value = "${azurerm_subnet.db_subnet.id}"
}

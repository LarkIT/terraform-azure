locals {
  network        = "${var.network[ "${var.environment}" ]}"
}

data "azurerm_subnet" "dbinst_subnet" {
  name                 = "${var.environment}_${var.application_name}_dbinst_subnet"
  virtual_network_name = "${var.environment}_${var.application_name}_vnet"
  resource_group_name  = "${var.resource_group}"
}

resource "azurerm_network_security_group" "sql_managed_instance" {
  name                = "sql_managed_instance"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
}

resource "azurerm_network_security_rule" "allow_management_inbound" {
  name                        = "allow_management_inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_ranges     = [9000,9003,1438,1440,1452]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "allow_subnet_inbound" {
  name                        = "allow_subnet_inbound"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_ranges     = [9000,9003,1438,1440,1452]
  source_address_prefix       = "${data.azurerm_subnet.dbinst_subnet.address_prefix}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

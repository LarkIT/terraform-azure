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
  destination_port_range      = "*"
  source_address_prefix       = "${data.azurerm_subnet.dbinst_subnet.address_prefix}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "allow_health_probe_inbound" {
  name                        = "allow_health_probe_inbound"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "allow_tds_inbound" {
  name                        = "allow_tds_inbound"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "allow_redirect_inbound" {
  name                        = "allow_redirect_inbound"
  priority                    = 1100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "11000-11999"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "allow_geodr_inbound" {
  name                        = "allow_geodr_inbound"
  priority                    = 1200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "5022"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "deny_all_inbound" {
  name                        = "deny_all_inbound"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "allow_management_outbound" {
  name                        = "allow_management_outbound"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_ranges     = [80,443,12000]
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "allow_subnet_outbound" {
  name                        = "allow_subnet_outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "${data.azurerm_subnet.dbinst_subnet.address_prefix}"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "allow_linkedserver_outbound" {
  name                        = "allow_linedserver_outbound"
  priority                    = 300
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "allow_redirect_outbound" {
  name                        = "allow_redirect_outbound"
  priority                    = 1100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "11000-11999"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

resource "azurerm_network_security_rule" "allow_geodr_outbound" {
  name                        = "allow_geodr_outbound"
  priority                    = 1200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = "5022"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = "${var.resource_group}"
  network_security_group_name = "${azurerm_network_security_group.sql_managed_instance.name}"
}

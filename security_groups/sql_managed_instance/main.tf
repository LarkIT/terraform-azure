resource "azurerm_network_security_group" "nsg-themis-test-sql3-mi-1" {
  name                = "nsg-themis-test-sql3-mi-1"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
}

#resource "azurerm_network_security_rule" "rdp" {
#  name                        = "rdp"
#  priority                    = 100
#  direction                   = "Inbound"
#  access                      = "Allow"
#  protocol                    = "Tcp"
#  source_port_range           = "*"
#  destination_port_range      = "3389"
#  source_address_prefix       = "*"
#  destination_address_prefix  = "*"
#  resource_group_name         = "${var.resource_group}"
#  network_security_group_name = "${azurerm_network_security_group.windows.name}"
#}
locals {
  resource_group = "${var.environment}_${var.application_name}_vnet"
  network        = "${var.network[ "${var.environment}" ]}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_group}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}_${var.application_name}_vnet"
  address_space       = ["${var.address_space}"]
  location            = "${var.location}"
  resource_group_name = "${local.resource_group}"
  dns_servers         = "${var.dns_servers}"
  depends_on          = ["azurerm_resource_group.rg"]
}

resource "azurerm_subnet" "dmz_subnet" {
  name                 = "${var.environment}_${var.application_name}_dmz_subnet"
  resource_group_name  = "${local.resource_group}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${lookup(local.network, "dmz")}"
  depends_on           = ["azurerm_virtual_network.vnet"]
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "${var.environment}_${var.application_name}_app_subnet"
  resource_group_name  = "${local.resource_group}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${lookup(local.network, "app")}"
  depends_on           = ["azurerm_virtual_network.vnet"]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.environment}_${var.application_name}_db_subnet"
  resource_group_name  = "${local.resource_group}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${lookup(local.network, "db")}"
  depends_on           = ["azurerm_virtual_network.vnet"]
}

#resource "azurerm_subnet" "domain_subnet" {
#  name                 = "${var.environment}_${var.application_name}_domain_subnet"
#  resource_group_name  = "${local.resource_group}"
#  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
#  address_prefix       = "${lookup(local.network, "domain")}"
#  depends_on           = ["azurerm_virtual_network.vnet"]
#}

#resource "azurerm_subnet" "agw_subnet" {
#  name                 = "${var.environment}_${var.application_name}_agw_subnet"
#  resource_group_name  = "${local.resource_group}"
#  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
#  address_prefix       = "${lookup(local.network, "agw")}"
#}

resource "azurerm_subnet" "dbinst_subnet" {
  name                 = "${var.environment}_${var.application_name}_dbinst_subnet"
  resource_group_name  = "${local.resource_group}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${lookup(local.network, "dbinst")}"
}
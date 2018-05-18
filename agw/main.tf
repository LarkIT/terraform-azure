locals {
  resource_group = "${var.environment}_${var.application_name}_gateway"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_group}"
  location = "${var.location}"
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.environment}_${var.application_name}_agw_subnet"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "10.254.0.0/24"
}

resource "azurerm_public_ip" "agw_pip" {
  name                         = "${var.environment}_${var.application_name}_agw_pip"
  location                     = "${var.location}"
  resource_group_name          = "${local.resource_group}"
  public_ip_address_allocation = "dynamic"
  depends_on                   = ["azurerm_resource_group.rg"]
}

resource "azurerm_application_gateway" "network" {
  name                = "${var.environment}_${var.application_name}-gateway-12345"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${var.location}"

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
#    subnet_id = "${var.subnet_id}"
    subnet_id = "${azurerm_subnet.subnet.id}"
  }

  frontend_port {
    name = "${var.vnet_name}-feport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${var.vnet_name}-feip"
    public_ip_address_id = "${azurerm_public_ip.agw_pip.id}"
  }

  backend_address_pool {
    name = "${var.vnet_name}-beap"
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = "${var.vnet_name}-httplstn"
    frontend_ip_configuration_name = "${var.vnet_name}-feip"
    frontend_port_name             = "${var.vnet_name}-feport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${var.vnet_name}-rqrt"
    rule_type                  = "Basic"
    http_listener_name         = "${var.vnet_name}-httplstn"
    backend_address_pool_name  = "${var.vnet_name}-beap"
    backend_http_settings_name = "${var.vnet_name}-be-htst"
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.environment}_${var.application_name}_agw_subnet"
  resource_group_name  = "${var.vnet_rg_name}"
  virtual_network_name = "${var.vnet_name}"
  address_prefix       = "${var.agw_subnet}"
}

resource "azurerm_public_ip" "agw_pip" {
  name                         = "${var.environment}_${var.application_name}_agw_pip"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group}"
  public_ip_address_allocation = "dynamic"
  depends_on                   = ["azurerm_resource_group.rg"]
}

resource "azurerm_application_gateway" "network" {
  name                = "${var.environment}_${var.application_name}-gateway-12345"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${var.location}"

  sku {
    name     = "${var.agw_size}"
    tier     = "${var.tier}"
    capacity = "${var.capacity}"
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = "${azurerm_subnet.subnet.id}"
  }

  frontend_port {
    name = "${var.vnet_name}-feport"
    port = "${var.port}"
  }

  frontend_ip_configuration {
    name                 = "${var.vnet_name}-feip"
    public_ip_address_id = "${azurerm_public_ip.agw_pip.id}"
  }

  backend_address_pool {
    name            = "${var.vnet_name}-beap"
    ip_address_list = "${var.ip_address_list}"
  }

  backend_http_settings {
    name                  = "${var.vnet_name}-be-htst"
    cookie_based_affinity = "Disabled"
    port                  = "${var.port}"
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

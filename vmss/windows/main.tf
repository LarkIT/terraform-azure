locals {
  default_tags = {
    environment      = "${var.environment}"
    application_name = "${var.application_name}"
  }

  tags = "${merge(local.default_tags, var.tags)}"
}

resource "azurerm_lb" "loadbalancer" {
  name                = "${var.environment}_${var.application_name}_loadbalancer"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  frontend_ip_configuration {
    name                          = "FrontEndIP"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address            = "${var.cluster_ip}"
    private_ip_address_allocation = "static"
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  name                = "BackEndAddressPool"
  resource_group_name = "${var.resource_group}"
  loadbalancer_id     = "${azurerm_lb.loadbalancer.id}"
}

resource "azurerm_lb_probe" "probe" {
  resource_group_name = "${var.resource_group}"
  loadbalancer_id     = "${azurerm_lb.loadbalancer.id}"
  name                = "http-running-probe"
  port                = 80
}

resource "azurerm_lb_rule" "lb_rule" {
  resource_group_name            = "${var.resource_group}"
  loadbalancer_id                = "${azurerm_lb.loadbalancer.id}"
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "FrontEndIP"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.bpepool.id}"
  probe_id                       = "${azurerm_lb_probe.probe.id}"
}

resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = "${var.environment}_${var.application_name}_vmss"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  upgrade_policy_mode = "Manual"

  #tags                = "${local.tags}"

  sku {
    name     = "${var.vmss_size}"
    tier     = "${var.tier}"
    capacity = "${var.capacity}"
  }

  storage_profile_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "testvm"
    admin_username       = "${var.admin_username}"
    admin_password       = "${var.admin_password}"
  }

  os_profile_windows_config {
    provision_vm_agent = false
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "TestIPConfiguration"
      subnet_id                              = "${var.subnet_id}"
      load_balancer_backend_address_pool_ids = ["${azurerm_lb_backend_address_pool.bpepool.id}"]
    }
  }
}

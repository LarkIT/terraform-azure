locals {
  storage_image_reference = "${var.storage_image_reference[ "${var.server_type}" ]}"
}

resource "azurerm_network_interface" "nic" {
  count                     = "${var.number_servers}"
  name                      = "${var.application_name}_${var.hostname}_nic_${count.index}"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group}"
  network_security_group_id = "${var.security_group}"

  ip_configuration {
    name                          = "${var.application_name}_${var.hostname}_nic_config_${count.index}"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "${var.nic_ip_allocation}"
    private_ip_address            = "${var.private_ip_address}"
  }

  tags {
    builtby = "Terraform"
  }
}

resource "azurerm_virtual_machine" "virtual_machine" {
  count                            = "${var.number_servers}"
  name                             = "${var.application_name}_${var.hostname}_vm_${count.index}"
  location                         = "${var.location}"
  resource_group_name              = "${var.resource_group}"
  network_interface_ids            = ["${element(azurerm_network_interface.nic.*.id, count.index)}"]
  vm_size                          = "${var.vm_size}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_os_disk {
    name              = "${var.application_name}_${var.hostname}_osdisk_${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.managed_disk_type}"
    disk_size_gb      = "${var.os_disk_size}"
  }

  storage_image_reference {
    publisher = "${local.storage_image_reference["publisher"]}"
    offer     = "${local.storage_image_reference["offer"]}"
    sku       = "${local.storage_image_reference["sku"]}"
    version   = "${local.storage_image_reference["version"]}"
  }

  os_profile {
    computer_name  = "${var.hostname}-${count.index}"
    admin_username = "${var.admin_username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = "${file("${var.ssh_public_key}")}"
    }
  }

  tags {
    builtby = "Terraform"
  }
}

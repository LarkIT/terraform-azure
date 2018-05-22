resource "azurerm_storage_account" "storage" {
  name                     = "${var.storage_name}"
  resource_group_name      = "${var.resource_group}"
  location                 = "${var.location}"
  account_tier             = "${var.account_tier}"
  account_replication_type = "${var.account_replication_type}"
}

resource "azurerm_storage_share" "file_share" {
  name                 = "${var.environment}_${var.application_name}_${var.file_share_name}"
  resource_group_name  = "${var.resource_group}"
  storage_account_name = "${azurerm_storage_account.storage.name}"
  quota                = "${var.quota}"
}

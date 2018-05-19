output "lb_id {
  value = "${azurerm_lb.loadbalancer.id}"
}

output "lb_ip_address" {
  value = "${azurerm_lb.loadbalancer.private_ip_address}"
}

output "bpepool_id" {
  value = "${azurerm_lb_backend_address_pool.bpepool.id}"
}

output "bpepool_name" {
  value = "${azurerm_lb_backend_address_pool.bpepool.id}"
}

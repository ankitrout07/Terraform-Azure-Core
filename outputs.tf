output "web_server_public_ip" {
  description = "Public IP of the web server"
  value       = azurerm_public_ip.pip.ip_address
}

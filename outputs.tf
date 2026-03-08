output "jira_ingress_ip" {
  value       = azurerm_public_ip.ingress_ip.ip_address
  description = "The static public IP for Jira ingress"
}

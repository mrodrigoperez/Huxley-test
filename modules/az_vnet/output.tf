output "vnet_name" {
  description = "The name of the created VNET"
  value       = azurerm_virtual_network.this.name
}

output "vnet_id" {
  description = "The ID of the created VNET"
  value       = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "A map of IDs for the created subnets"
  value       = { for s, subnet in azurerm_subnet.this : s => subnet.id }
}

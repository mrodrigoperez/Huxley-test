variable "vnet_name" {
  description = "The name of the VNET"
  type        = string
}

variable "address_space" {
  description = "The address space for the VNET"
  type        = list(string)
}

variable "location" {
  description = "Azure region where the VNET will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which the VNET will be created"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the VNET"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "Map of subnets to create within the VNET, including configuration details"
  type = map(object({
    address_prefixes = list(string)
    nsg_id           = string
  }))
  default = {}
}

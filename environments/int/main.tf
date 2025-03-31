resource "azurerm_resource_group" "int" {
  name     = "rg-int-eastus"
  location = "eastus"
  tags = {
    environment = "int"
    region      = "eastus"
  }
}

module "vnet" {
  source              = "../../modules/az_vnet"
  vnet_name           = "vnet-int"
  location            = azurerm_resource_group.int.location
  resource_group_name = azurerm_resource_group.int.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "int"
    project     = "huxley-test int"
  }
  subnets = {
    subnet1 = {
      address_prefixes = ["10.0.1.0/24"]
      nsg_id           = ""
    }
  }
}

# Additional resource: Storage Account
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "int_storage" {
  name                     = "stint${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.int.name
  location                 = azurerm_resource_group.int.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "int"
    region      = "euwest"
  }
}

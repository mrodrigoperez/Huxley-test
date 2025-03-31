resource "azurerm_resource_group" "dev" {
  name     = "rg-dev-eastus"
  location = "eastus"
  tags = {
    environment = "dev"
    region      = "eastus"
  }
}

module "vnet" {
  source              = "../../modules/az_vnet"
  vnet_name           = "vnet-dev"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "dev"
    project     = "huxley-test"
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

resource "azurerm_storage_account" "dev_storage" {
  name                     = "stdev${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.dev.name
  location                 = azurerm_resource_group.dev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "dev"
    region      = "euwest"
  }
}

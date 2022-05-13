terraform {
  backend "azurerm" {
    resource_group_name  = "tia-testingterraform2313-rg"
    storage_account_name = "testingterraform2313"
    container_name       = "terraformstate"
    key                  = "terraformstate.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "tf-demo-rg"
  location = "westeurope"
}

#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "tf-demo-vnet"
  address_space       = ["10.0.0.0/24"]
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.0.0/25"
}

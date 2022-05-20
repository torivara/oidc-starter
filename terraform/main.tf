terraform {
  backend "azurerm" {
    resource_group_name  = "tia-testingterraform2313-rg"
    storage_account_name = "testingterraform2313"
    container_name       = "terraformstate"
    key                  = "terraformstate.tfstate"
    use_oidc             = true
    subscription_id      = "cf824313-8235-4ab9-8c52-83518a61f62f"
    tenant_id            = "0c178fd5-1459-41d5-8731-3908efd207ea"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.7.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
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
  address_prefixes     = ["10.0.0.0/25"]
}
# Create Subnet
resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.128/25"]
}

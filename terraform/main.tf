terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-oidc-state"
    storage_account_name = "tiaterraformoidc"
    container_name       = "terraformstate"
    key                  = "terraformstate.tfstate"
    use_oidc             = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.7.0"
    }
  }
}

variable "input1" {
  description = "This is a test variable input"
  type        = string
  default     = "defaultValue"
}

variable "input2" {
  description = "This is a test variable input"
  type        = string
  default     = "defaultValue"
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

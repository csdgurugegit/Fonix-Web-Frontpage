terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.104.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.set_subscription_id
  client_id	= var.set_client_id
  client_secret = var.set_client_secret
  tenant_id = var.set_tenant_id
  features {}
}

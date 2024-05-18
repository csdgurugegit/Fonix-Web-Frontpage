terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.104.0"
    }
  }
}

provider "azurerm" {
 subscription_id = ""
 client_id	     = ""
 client_secret   = ""
 tenant_id       = ""
 features {}
}

resource "azurerm_resource_group" "resource" {
  name     = "fonix_RRG"
  location = "Central India"
}

resource "azurerm_app_service_plan" "svcplan" {
  name                = "fonix-appserviceplan"
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

locals {
  env_variables = {
    DOCKER_REGISTRY_SERVER_URL      = "https://index.docker.io/v1/"
    DOCKER_REGISTRY_SERVER_USERNAME = "dockerhub-username"
    DOCKER_REGISTRY_SERVER_PASSWORD = "dockerhub-access-token"
  }
}

resource "azurerm_app_service" "myapp" {
  name                = "fonixwebservice252"
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
  app_service_plan_id = azurerm_app_service_plan.svcplan.id

  site_config {
    linux_fx_version = "DOCKER|dockerhub-username/repo-name:1.1"
  }

  app_settings = local.env_variables
}


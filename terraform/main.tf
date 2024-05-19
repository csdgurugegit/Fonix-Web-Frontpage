resource "azurerm_resource_group" "resource" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_service_plan" "svcplan" {
  name                = var.service_plan_name
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
  os_type             = "Linux"
  sku_name            = var.sku_tier
}

resource "azurerm_app_service" "myapp" {
  name                = var.app_service_name
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
  app_service_plan_id = azurerm_service_plan.svcplan.id

  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|${var.dockerhub_username}/fonix-webapp:1.1"
  }
  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT"      = "true"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "https://index.docker.io/v1/"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = var.dockerhub_username
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = var.dockerhub_access_token
  }  
}

output "myapp_name" {
  value = azurerm_app_service.myapp.name
}

resource "azurerm_monitor_autoscale_setting" "autscale" {
  name                = "fonixappscale"
  resource_group_name = azurerm_service_plan.svcplan.resource_group_name
  location            = azurerm_service_plan.svcplan.location
  target_resource_id  = azurerm_service_plan.svcplan.id

  profile {
    name = "defaultProfile"
    capacity {
      default = 1
      minimum = 1
      maximum = 2
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.svcplan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 5
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.svcplan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 80
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
   
}

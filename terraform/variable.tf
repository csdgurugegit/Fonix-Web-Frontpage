variable "rg_name" {
  description = "Resource Group Name"
  type        = string
}

variable "rg_location" {
  description = "Resource Group Location"
  type        = string
}

variable "service_plan_name" {
    description = "App Service Plan Name"
    type        = string
}

variable "sku_tier" {
    description = "App Service Plan SKU Tier Name"
    type        = string 
}

variable "app_service_name" {
    description = "App Service Name"
    type        = string
}

variable "dockerhub_username" {
  description = "DockerHub Username"
  type        = string
}

variable "dockerhub_access_token" {
  description = "DockerHub Access Token"
  type        = string
}

variable "set_subscription_id" {
  description = "Provider Subscription ID "
  type        = string
}

variable "set_client_id" {
  description = "Provider Client ID"
  type        = string
}

variable "set_client_secret" {
  description = "Provider Client Secret"
  type        = string
}

variable "set_tenant_id" {
  description = "Provider Tenant ID"
  type        = string
}
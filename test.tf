provider "azurerm" {}

resource "azurerm_resource_group" "rg" {
  name     = "tf-rg"
  location = "eastus"
}

resource "azurerm_app_service_plan" "appPlan" {
  name                = "free-tf-plan"
  resource_group_name = "tf-rg"

  sku = {
    tier = "free"
    size = "F1"
  }

  location = "eastus"
}

resource "azurerm_app_service" "appFrontend" {
  app_service_plan_id = "${azurerm_app_service_plan.appPlan.id}"
  resource_group_name = "tf-rg"
  name                = "tf-frontend"
  location            = "eastus"

  app_settings {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.appAI.instrumentation_key}"
  }
}

resource "azurerm_app_service" "appBackend" {
  app_service_plan_id = "${azurerm_app_service_plan.appPlan.id}"
  resource_group_name = "tf-rg"
  name                = "tf-backend"
  location            = "eastus"

  app_settings {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.appAI.instrumentation_key}"
  }
}

resource "azurerm_application_insights" "appAI" {
  name                = "tf-appInsights"
  location            = "eastus"
  resource_group_name = "tf-rg"
  application_type    = "Web"
}

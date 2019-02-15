provider "azurerm" {}

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg}"
  location = "${var.location}"
}

resource "azurerm_app_service_plan" "appPlan" {
  name                = "free-tf-plan"
  resource_group_name = "${var.rg}"

  sku = {
    tier = "free"
    size = "F1"
  }

  location = "${var.location}"
}

resource "azurerm_app_service" "appFrontend" {
  app_service_plan_id = "${azurerm_app_service_plan.appPlan.id}"
  resource_group_name = "${var.rg}"
  name                = "tf-frontend"
  location            = "${var.location}"

  app_settings {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.appAI.instrumentation_key}"
  }
}

resource "azurerm_app_service" "appBackend" {
  app_service_plan_id = "${azurerm_app_service_plan.appPlan.id}"
  resource_group_name = "${var.rg}"
  name                = "tf-backend"
  location            = "${var.location}"

  app_settings {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.appAI.instrumentation_key}"
  }
}

resource "azurerm_application_insights" "appAI" {
  name                = "tf-appInsights"
  location            = "${var.location}"
  resource_group_name = "${var.rg}"
  application_type    = "Web"
}

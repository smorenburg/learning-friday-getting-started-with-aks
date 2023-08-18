terraform {
  required_providers {
    azurerm = {
      version = ">= 3.70"
    }
    random = {
      version = ">= 3.5"
    }
    http = {
      version = ">= 3.4"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-friday-weu"
    storage_account_name = "stfriday091293"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

data "azurerm_client_config" "current" {}

# Get the public IP address.
data "http" "public_ip" {
  url = "https://ifconfig.co/ip"
}

locals {
  # Set the application name.
  app = "friday"

  # Set the tags.
  tags = {
    Environment = "Development"
  }

  # Lookup and set the location abbreviation, defaults to na (not available).
  location_abbreviation = try(var.location_abbreviation[var.location], "na")

  # Construct the name suffix.
  suffix = "${local.app}-${var.environment}-${local.location_abbreviation}"

  # Clean and set the public IP address.
  public_ip = chomp(data.http.public_ip.response_body)

  # Set the authorized IP ranges for the Kubernetes cluster.
  authorized_ip_ranges = ["${local.public_ip}/32"]
}

# Create the resource group.
resource "azurerm_resource_group" "default" {
  name     = "rg-${local.suffix}"
  location = var.location
  tags     = local.tags
}

# Create the Log Analytics workspace.
resource "azurerm_log_analytics_workspace" "default" {
  name                = "log-${local.suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.default.name
  retention_in_days   = 30
}

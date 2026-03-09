terraform {
  backend "azurerm" {
  # Change these values
    resource_group_name  = "terraform-remote-state"
    storage_account_name = "atlassianterraformrs"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
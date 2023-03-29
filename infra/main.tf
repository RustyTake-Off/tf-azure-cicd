##################################################
# Terraform and providers configuration
terraform {

  ##################################################
  # Required Terraform version 
  required_version = ">= 1.3.0, < 2.0.0"

  ##################################################
  # Required providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }

    ##################################################
    # Backend configuration
    # backend "azurerm" {
    #   resource_group_name  = "rgpr08pro"
    #   storage_account_name = "strapr08pro"
    #   container_name       = "contpr08pro"
    #   key                  = "prod.08pro.tfstate"
    # }
  }
}

##################################################
# Providers configurations
provider "azurerm" {
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  # subscription_id = var.subscription_id
  # tenant_id       = var.tenant_id

  features {}
}

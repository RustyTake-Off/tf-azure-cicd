##################################################
# Terraform and providers configuration
terraform {

  ##################################################
  # Required Terraform version 
  required_version = ">= 1.3.0, < 2.0.0"
  # again
  ##################################################
  # Required providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }

    ##################################################
    # Backend configuration taken from *.backend.tfvars file
    # backend "azurerm" {}
  }
}

##################################################
# Providers configurations
provider "azurerm" {
  # client_id       = var.ARM_CLIENT_ID
  # client_secret   = var.ARM_CLIENT_SECRET
  # subscription_id = var.ARM_SUBSCRIPTION_ID
  # tenant_id       = var.ARM_TENANT_ID

  features {}
}

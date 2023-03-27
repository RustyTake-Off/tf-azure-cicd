##################################################
# Module caf - configuration
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 5.5.0"
  providers = {
    azurerm.vhub = azurerm
  }

  global_settings = var.global_settings
  resource_groups = var.resource_groups
}

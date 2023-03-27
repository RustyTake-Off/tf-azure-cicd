##################################################
# Resources - configuration
resource "azurerm_resource_group" "this" {

  name     = "rg-${var.global.rg_aks}-${var.global.suffix}"
  location = var.global.location
}

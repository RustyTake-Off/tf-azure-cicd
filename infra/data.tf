# Get data from Azure
data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "node_rg" {
  name = azurerm_kubernetes_cluster.this.node_resource_group
}

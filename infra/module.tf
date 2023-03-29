##################################################
# Resources - configuration
resource "azurerm_resource_group" "this" {

  name     = "rg-${var.global.name}-${var.global.suffix}"
  location = var.global.location
}

# Network - configuration
resource "azurerm_virtual_network" "this" {

  name                = "vnet-${var.global.name}-${var.global.suffix}"
  location            = var.global.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.network.vnet_address_space
}

resource "azurerm_subnet" "this" {

  name                 = "subnet-${var.global.name}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.network.subnet_address_prefixes
}

# Aks - configuration
resource "azurerm_user_assigned_identity" "this" {

  name                = "uai-${var.global.name}-${var.global.suffix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_role_assignment" "thisone" {

  principal_id         = azurerm_user_assigned_identity.this.principal_id
  role_definition_name = "Contributor"
  scope                = azurerm_resource_group.this.id
}

resource "azurerm_role_assignment" "thistwo" {

  principal_id         = azurerm_user_assigned_identity.this.principal_id
  role_definition_name = "Contributor"
  scope                = data.azurerm_resource_group.node_rg.id
}

resource "azurerm_kubernetes_cluster" "this" {

  name                = lower("aks-${var.global.suffix}")
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = lower("aks${var.global.suffix}")

  kubernetes_version               = var.aks.kube_version
  azure_policy_enabled             = true
  automatic_channel_upgrade        = var.aks.auto_channel_upgrade
  sku_tier                         = var.aks.sku_tier
  http_application_routing_enabled = try(var.aks.AksHTTPAppRouting, false)

  default_node_pool {
    name            = lower(var.aks.dnp_name)
    node_count      = var.aks.node_count
    vm_size         = var.aks.vm_size
    os_sku          = "Ubuntu"
    scale_down_mode = "Delete"
    type            = "VirtualMachineScaleSets"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  network_profile {
    network_plugin     = try(var.aks.network_plugin, "kubenet")
    service_cidr       = try(var.aks.service_cidr, null)
    dns_service_ip     = try(var.aks.dns_service_ip, null)
    docker_bridge_cidr = try(var.aks.docker_bridge_cidr, null)
    pod_cidr           = try(var.aks.pod_cidr, null)
    network_policy     = try(var.aks.network_policy, null)
  }

  linux_profile {
    admin_username = var.ssh.admin

    ssh_key {
      key_data = var.ssh.ssh_key
    }
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  }
}

# Log analytics - configuration
resource "azurerm_log_analytics_workspace" "this" {

  name                = lower("law-${var.global.suffix}")
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_log_analytics_solution" "this" {

  solution_name         = "ContainerInsights"
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  workspace_resource_id = azurerm_log_analytics_workspace.this.id
  workspace_name        = azurerm_log_analytics_workspace.this.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

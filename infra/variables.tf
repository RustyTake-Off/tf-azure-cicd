##################################################
# Static variables
# variable "ARM_CLIENT_ID" {
#   sensitive = true
# }
# variable "ARM_CLIENT_SECRET" {
#   sensitive = true
# }
# variable "ARM_SUBSCRIPTION_ID" {
#   sensitive = true
# }
# variable "ARM_TENANT_ID" {
#   sensitive = true
# }

##################################################
# Resources - variables
variable "global" {
  description = "Configuration - global variables"
  default = {
    suffix   = "08pro"
    location = "westeurope"
    name     = "aks"
  }
}

# Network - variables
variable "network" {
  description = "Configuration - network variables"
  default = {
    vnet_address_space      = ["10.0.0.0/16"]
    subnet_address_prefixes = ["10.0.1.0/24"]
  }
}

# Aks - variables
variable "aks" {
  description = "Configuration - aks variables"
  default = {
    kube_version         = "1.25.5"
    auto_channel_upgrade = "patch"
    sku_tier             = "Free"
    dnp_name             = "default"
    node_count           = 1
    vm_size              = "Standard_D2_v2"

    # network_plugin     = "kubenet"
    # service_cidr       = ""
    # dns_service_ip     = ""
    # docker_bridge_cidr = ""
    # pod_cidr           = ""
    # network_policy     = ""
  }
}

variable "ssh" {
  description = "Configuration - ssh variables"
  sensitive   = true
  default     = {}
}

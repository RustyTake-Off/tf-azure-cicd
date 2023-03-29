##################################################
# Static variables
# variable "client_id" {
#   sensitive = true
# }
# variable "client_secret" {
#   sensitive = true
# }
# variable "subscription_id" {
#   sensitive = true
# }
# variable "tenant_id" {
#   sensitive = true
# }

##################################################
# Resources - variables
variable "global" {
  description = "Configuration - global variables"
  default = {
    suffix   = "pro08"
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
  type = object({
    admin   = string
    ssh_key = string
  })
  default = {
    admin   = null
    ssh_key = null
  }
}

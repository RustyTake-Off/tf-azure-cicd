##################################################
# Static variables
variable "ARM_CLIENT_ID" {
  sensitive = true
}
variable "ARM_CLIENT_SECRET" {
  sensitive = true
}
variable "ARM_SUBSCRIPTION_ID" {
  sensitive = true
}
variable "ARM_TENANT_ID" {
  sensitive = true
}

##################################################
# Module caf - variables
variable "global_settings" {
  description = "Configuration object - global_settings"
  default = {
    default_region = "region_euw"
    regions = {
      region_euw = "westeurope"
    }
  }
}

variable "resource_groups" {
  description = "Configuration object - resource_groups"
  default = {

  }
}

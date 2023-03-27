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
  description = "Configuration - global"
  default = {
    suffix   = "08pro"
    location = "westeurope"
    rg_aks   = "aks"
  }
}


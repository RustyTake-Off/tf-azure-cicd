##################################################
# Module caf - production variables
global_settings = {
  default_region = "region_euw"
  regions = {
    region_euw = "westeurope"
  }
}

resource_groups = {
  rg_aks = {
    name   = "rg-aks"
    region = "region_euw"
  }
}

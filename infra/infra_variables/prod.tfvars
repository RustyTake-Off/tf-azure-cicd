global = {
  suffix   = "pro99"
  location = "westeurope"
  name     = "default"
}

network = {
  vnet_address_space      = ["10.0.0.0/16"]
  subnet_address_prefixes = ["10.0.1.0/24"]
}

aks = {
  kube_version         = "1.25.5"
  auto_channel_upgrade = "patch"
  sku_tier             = "Free"
  dnp_name             = "default"
  node_count           = 1
  vm_size              = "Standard_D2_v2"
}

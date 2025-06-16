locals {
  default_location = "West US"
  default_name = "simple_machine"
  machine_name = "simpleMachine"
}

data "azurerm_location" "this" {
  location = local.default_location
}

resource "azurerm_resource_group" "this" {
  name     = local.default_name
  location = data.azurerm_location.this.display_name
}

module "nsg" {
  source  = "Azure/network-security-group/azurerm"
  version = "4.1.0"
  
  resource_group_name = azurerm_resource_group.this.name
  security_group_name = local.default_name
  predefined_rules = [
    { name = "HTTP", priority = 500 }
  ]

  depends_on = [ azurerm_resource_group.this ]
}

module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.8.1"
  
  address_space = ["172.17.0.0/16"]
  location = data.azurerm_location.this.display_name
  name = local.default_name
  resource_group_name = local.default_name

  subnets = {
    this = {
        name = local.default_name
        address_prefixes = ["172.17.0.0/24"]
        network_security_group = { id = module.nsg.network_security_group_id }
    }
  }
}

module "vm" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.17.0"
  
  location = data.azurerm_location.this.display_name
  name = local.machine_name
  resource_group_name = local.default_name
  zone = try(data.azurerm_location.this.zone_mappings[0].logical_zone, null)
  network_interfaces = {
    this = {
        name = local.default_name
        ip_configurations = {
            this = {
                name = local.default_name
                private_ip_subnet_resource_id = module.vnet.subnets.this.resource_id
                create_public_ip_address      = true
                public_ip_address_name        = local.default_name
            }
        }
    }
  }
  os_disk = { "caching": "None", "storage_account_type": "Standard_LRS" }
  os_type = "Linux"
  sku_size = "Standard_A1_v2"
  source_image_reference = { "offer": "debian-12", "publisher": "Debian", "sku": "12", "version": "latest" }
  boot_diagnostics = true
  user_data = base64encode("sudo apt update && sudo apt install nginx -y && sudo systemctl enable --now nginx")
}
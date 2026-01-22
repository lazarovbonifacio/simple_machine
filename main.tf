module "libvirt" {
  count     = var.cloud_provider == "libvirt" ? 1 : 0
  source    = "./modules/libvirt"
  so        = var.so
  instances = var.instance_count
}

module "aws" {
  count     = var.cloud_provider == "aws" ? 1 : 0
  source    = "./modules/aws"
  instances = var.instance_count
}

module "azure" {
  count     = var.cloud_provider == "azure" ? 1 : 0
  source    = "./modules/azure"
  instances = var.instance_count
}

module "gcp" {
  count     = var.cloud_provider == "gcp" ? 1 : 0
  source    = "./modules/gcp"
  instances = var.instance_count
}

module "do" {
  count     = var.cloud_provider == "digitalocean" ? 1 : 0
  source    = "./modules/digitalocean"
  instances = var.instance_count
}

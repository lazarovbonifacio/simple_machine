module "libvirt" {
  count     = var.libvirt != null ? 1 : 0
  source    = "./modules/libvirt"
  instances = var.libvirt.instance_count
  so        = var.libvirt.so
}

module "aws" {
  count     = var.aws != null ? 1 : 0
  source    = "./modules/aws"
  instances = var.aws.instance_count
  so        = var.aws.so
}

module "azure" {
  count     = var.azure != null ? 1 : 0
  source    = "./modules/azure"
  instances = var.azure.instance_count
  so        = var.azure.so
}

module "gcp" {
  count     = var.gcp != null ? 1 : 0
  source    = "./modules/gcp"
  instances = var.gcp.instance_count
  so        = var.gcp.so
}

module "do" {
  count     = var.digitalocean != null ? 1 : 0
  source    = "./modules/digitalocean"
  instances = var.digitalocean.instance_count
  so        = var.digitalocean.so
}

module "aws" {
  source = "./modules/aws"
}

module "libvirt" {
  source = "./modules/libvirt"
}

module "azure" {
  source = "./modules/azure"
}

module "gcp" {
  source = "./modules/gcp"
}

module "do" {
  source = "./modules/digitalocean"
}
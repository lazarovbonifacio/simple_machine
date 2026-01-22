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

# module "azure" {
#   source = "./modules/azure"
# }

# module "gcp" {
#   source = "./modules/gcp"
# }

# module "do" {
#   source = "./modules/digitalocean"
# }

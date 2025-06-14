module "aws" {
  source = "./modules/aws"
  provider_aws_profile = "personal"
}

module "libvirt" {
  source = "./modules/libvirt"
}

module "azure" {
  source = "./modules/azure"
  provider_azurerm_subscription_id = "91033b90-1bb3-4fcd-ba74-ec4f6d0a6447"
}

module "gcp" {
  source = "./modules/gcp"
  project_id = "rational-camera-451015-h6"
}
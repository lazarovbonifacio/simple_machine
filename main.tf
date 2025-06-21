module "aws" {
  source = "./modules/aws"
  provider_aws_profile = var.provider_aws_profile
}

module "libvirt" {
  source = "./modules/libvirt"
}

module "azure" {
  source = "./modules/azure"
  provider_azurerm_subscription_id = var.provider_azurerm_subscription_id
}

module "gcp" {
  source = "./modules/gcp"
  project_id = var.provider_google_project_id
}
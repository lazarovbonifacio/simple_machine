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

module "alibaba" {
  count     = var.alibaba != null ? 1 : 0
  source    = "./modules/alibaba"
  instances = var.alibaba.instance_count
  so        = var.alibaba.so
}

module "oracle" {
  count          = var.oracle != null ? 1 : 0
  source         = "./modules/oracle"
  instances      = var.oracle.instance_count
  so             = var.oracle.so
  compartment_id = var.oracle.compartment_id
}

module "linode" {
  count     = var.linode != null ? 1 : 0
  source    = "./modules/linode"
  instances = var.linode.instance_count
  so        = var.linode.so
}

module "ibm" {
  count             = var.ibm != null ? 1 : 0
  source            = "./modules/ibm"
  instances         = var.ibm.instance_count
  so                = var.ibm.so
  resource_group_id = var.ibm.resource_group_id
}

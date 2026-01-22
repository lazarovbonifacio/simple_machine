provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      terraformed     = "true"
      project         = "simple_machine"
      author          = "lazarovbonifacio"
      ambiente        = "portfolio"
      centro_de_custo = "eng"
    }
  }
  profile = var.provider_aws_profile
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.provider_azurerm_subscription_id
}

provider "google" {
  project = var.provider_google_project_id
  region  = "us-central1"
  default_labels = {
    terraformed     = "true"
    project         = "simple_machine"
    author          = "lazarovbonifacio"
    ambiente        = "portfolio"
    centro_de_custo = "eng"
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

provider "digitalocean" {
  token = var.provider_do_token
}

provider "linode" {
  token = var.provider_linode_token
}

provider "alicloud" {
  access_key = var.provider_alicloud_access_key
  secret_key = var.provider_alicloud_secret_key
  region     = "cn-beijing"
}

provider "oci" {
  tenancy_ocid = var.provider_oci_tenancy_ocid
  region       = "us-ashburn-1"
}

provider "ibm" {
  ibmcloud_api_key = var.provider_ibm_api_key
  region           = "us-south"
}

terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.3"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.39.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.117.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.57.0"
    }
    linode = {
      source  = "linode/linode"
      version = "3.8.0"
    }
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.268.0"
    }
    oci = {
      source  = "oracle/oci"
      version = "7.30.0"
    }
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.87.2"
    }
  }
}

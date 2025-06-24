provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      terraformed = "true"
      project = "simple_machine"
      author = "lazarovbonifacio"
      ambiente = "portfolio"
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
  project     = var.provider_google_project_id
  region      = "us-central1"
  default_labels = {
    terraformed = "true"
    project = "simple_machine"
    author = "lazarovbonifacio"
    ambiente = "portfolio"
    centro_de_custo = "eng"
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

provider "digitalocean" {
  token = var.provider_do_token
}

terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    google = {
      source = "hashicorp/google"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
    aws = {
      source = "hashicorp/aws"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}
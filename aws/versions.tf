terraform {
  required_version = ">= 1.11"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      terraformed = "true"
      project = "simple_machine"
      author = "lazarovbonifacio"
    }
  }
}
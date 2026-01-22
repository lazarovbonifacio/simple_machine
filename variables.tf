variable "aws" {
  description = "AWS Configuration"
  type = object({
    instance_count = number
    so             = string
  })
  default = null
}

variable "azure" {
  description = "Azure Configuration"
  type = object({
    instance_count = number
    so             = string
  })
  default = null
}

variable "gcp" {
  description = "GCP Configuration"
  type = object({
    instance_count = number
    so             = string
  })
  default = null
}

variable "digitalocean" {
  description = "DigitalOcean Configuration"
  type = object({
    instance_count = number
    so             = string
  })
  default = null
}

variable "libvirt" {
  description = "Libvirt Configuration"
  type = object({
    instance_count = number
    so             = string
  })
  default = null
}

variable "provider_aws_profile" {
  type    = string
  default = "default"
}

variable "provider_azurerm_subscription_id" {
  type    = string
  default = ""
}

variable "provider_google_project_id" {
  type    = string
  default = ""
}

variable "provider_do_token" {
  type    = string
  default = ""
}

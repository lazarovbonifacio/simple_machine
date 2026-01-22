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

variable "alibaba" {
  description = "Alibaba Cloud Configuration"
  type = object({
    instance_count = number
    so             = string
  })
  default = null
}

variable "oracle" {
  description = "Oracle Cloud Configuration"
  type = object({
    instance_count = number
    so             = string
    compartment_id = string
  })
  default = null
}

variable "linode" {
  description = "Linode (Akamai) Configuration"
  type = object({
    instance_count = number
    so             = string
  })
  default = null
}

variable "ibm" {
  description = "IBM Cloud Configuration"
  type = object({
    instance_count    = number
    so                = string
    resource_group_id = string
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

variable "provider_linode_token" {
  type    = string
  default = ""
}

variable "provider_ibm_api_key" {
  type    = string
  default = ""
}

variable "provider_alicloud_access_key" {
  type    = string
  default = ""
}

variable "provider_alicloud_secret_key" {
  type    = string
  default = ""
}

variable "provider_oci_tenancy_ocid" {
  type    = string
  default = ""
}

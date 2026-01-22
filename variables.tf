variable "cloud_provider" {
  description = "Cloud provider to provision resources. Options: aws, libvirt"
  type        = string
  default     = "libvirt"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "so" {
  description = "Operating System (for libvirt). Options: ubuntu, debian"
  type        = string
  default     = "ubuntu"
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

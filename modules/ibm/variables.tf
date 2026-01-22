variable "instances" {
  description = "Number of instances to provision"
  type        = number
  default     = 1
}

variable "so" {
  description = "Operating System (ubuntu or debian)"
  type        = string
  default     = "ubuntu"
}

variable "resource_group_id" {
  description = "IBM Resource Group ID"
  type        = string
  default     = null
}

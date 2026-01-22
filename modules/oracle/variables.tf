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

variable "compartment_id" {
  description = "OCI Compartment ID"
  type        = string
  default     = null # Should be provided by env or root var
}

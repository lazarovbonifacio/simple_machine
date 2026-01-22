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

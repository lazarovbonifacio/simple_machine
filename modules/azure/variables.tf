variable "instances" {
  description = "Number of instances to create"
  default     = 1
  type        = number
}

variable "so" {
  description = "Operating System. Choose between: debian or ubuntu"
  type        = string
}

variable "so" {
  description = "Operation System. Choose between: debian or ubuntu"
  default     = "debian"
  type        = string
}

variable "instances" {
  description = "Number of instances to create"
  default     = 1
  type        = number
}

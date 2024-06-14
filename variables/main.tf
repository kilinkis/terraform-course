variable "vpcname" {
  description = "Name of the VPC"
  type        = string
  default     = "myvpc"
}

variable "sshport" {
  description = "SSH port"
  type        = number
  default     = 22
}
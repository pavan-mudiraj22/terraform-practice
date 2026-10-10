variable "vpc_cidr" {
  description = "cidr value for vpc"
  default     = "10.0.0.0/16"
  type        = string
}

variable "subnet_cidr" {
  description = "cidr for subnet"
  default     = "10.0.0.0/24"
  type        = string
}
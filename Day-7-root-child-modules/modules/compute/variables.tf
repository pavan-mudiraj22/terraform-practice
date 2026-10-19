variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-00f0b088032c72fda"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}
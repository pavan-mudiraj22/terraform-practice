resource "aws_instance" "my_instance" {
ami = var.ami_id
instance_type = var.instance_type
availability_zone = var.az
tags = var.tags
  
}
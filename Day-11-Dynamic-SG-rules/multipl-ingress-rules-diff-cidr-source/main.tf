resource "aws_security_group" "devops_project_pavan" {
  name        = "devops-project-pavan"
  description = "DevOps project security group"


  dynamic "ingress" {
    for_each = [
      { port = 22,   cidr = ["192.168.1.10/32"] },
      { port = 80,   cidr = ["0.0.0.0/0"] },
      { port = 443,  cidr = ["0.0.0.0/0"] },
      { port = 8080, cidr = ["192.168.1.10/32"] },
      { port = 3000, cidr = ["10.0.0.0/16"] },
      { port = 3306, cidr = ["10.0.3.0/24"] },
      { port = 5000, cidr = ["10.0.4.0/24"] }
    ]

    content {
      description = "Allow port ${ingress.value.port}"
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project-pavan"
  }
}
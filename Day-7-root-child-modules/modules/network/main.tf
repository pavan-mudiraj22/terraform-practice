resource "aws_vpc" "name" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "dev" {
  cidr_block = var.subnet_cidr
  vpc_id     = aws_vpc.name.id

  tags = {
    Name = "my-subnet"
  }
}


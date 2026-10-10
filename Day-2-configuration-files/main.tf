resource "aws_vpc" "dev" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "my-vpc"
  }

}

resource "aws_subnet" "test" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = "my-subnet"
  }

}

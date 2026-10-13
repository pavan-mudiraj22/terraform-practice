resource "aws_instance" "dev" {
  ami           = "ami-0cd26b05d55882da3"
  instance_type = "t3.micro"

  tags = {
    Name = "pavan"
  }
}               
resource "aws_instance" "dev" {
  ami           = "ami-0857ef7554aab20ef"
  instance_type = "t3.micro"

  tags = {
    Name = "pavan"
  }
}               
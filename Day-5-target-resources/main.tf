resource "aws_instance" "dev" {
  ami           = "ami-0857ef7554aab20ef"
  instance_type = "t3.small"

  tags = {
    Name = "pavan-ee"
  }
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "pavan-terraform-practice-bucket"
}
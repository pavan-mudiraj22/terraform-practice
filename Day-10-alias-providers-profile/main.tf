resource "aws_instance" "name" {
    ami = "ami-0cd26b05d55882da3"
    instance_type = "t3.micro"
    tags = {
        Name = "dev-2"
    }
  #us-east-1
}
resource "aws_s3_bucket" "name" {
 bucket = "dev-test-prod-pavan"
 provider = aws.dev
 #us-west-2
}
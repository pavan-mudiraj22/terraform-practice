resource "aws_instance" "name" {
    ami = "ami-0cd26b05d55882da3"
    instance_type = "t3.micro"
    user_data = file("userdata.sh")
    tags = {
        Name = "dev-2"
    }
  
}
variable "nit" {
  type = list(string)
  default = ["dev", "test", "prod"]
}



resource "aws_instance" "name" {
    ami = "ami-0cd26b05d55882da3"
    instance_type = "t3.micro"
    count=length(var.nit)
    tags = {
        Name = var.nit[count.index]
    }

  
}
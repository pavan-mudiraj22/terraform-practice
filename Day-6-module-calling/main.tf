module "ec2_instance" {
  source = "../Day-6-ec2-modules"
  ami_id = "ami-0857ef7554aab20ef"
  instance_type = "t3.small"
  az = "us-west-1a"
  tags = {
    Name = "dev"
  }
}
terraform {
  backend "s3" {
    bucket       = "amz-pav-backend"
    key          = "dev/terraform.tfstate"
    region       = "us-west-1"
    encrypt      = true
   # use_lockfile = true
  }
}
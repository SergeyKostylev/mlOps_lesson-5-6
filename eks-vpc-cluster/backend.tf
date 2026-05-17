terraform {
  backend "s3" {
    key    = "root/terraform.tfstate"
    region = "us-east-1"
  }
}

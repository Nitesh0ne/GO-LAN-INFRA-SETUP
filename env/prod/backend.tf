terraform {
  backend "s3" {
    bucket = "golang-infra-state-store1010"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}
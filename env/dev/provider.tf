provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["d:\\CRED\\terraform_cred.txt"]
}

terraform {
  backend "s3" {
    bucket = "golang-infra-state-store1010"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    shared_credentials_files = ["d:\\CRED\\terraform_cred.txt"]
    
  }
}

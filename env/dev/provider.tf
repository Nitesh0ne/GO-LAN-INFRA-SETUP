provider "aws" {
  region     = "us-east-1"
  access_key = data.vault_generic_secret.aws_creds.data["access_key"]
  secret_key = data.vault_generic_secret.aws_creds.data["secret_key"]
}

terraform {
  backend "s3" {
    bucket                   = "golang-infra-state-store1010"
    key                      = "dev/terraform.tfstate"
    region                   = "us-east-1"
    shared_credentials_files = ["d:\\CRED\\terraform_cred.txt"]
  }
}


provider "vault" {
  address = "http://127.0.0.1:8200"
}

data "vault_generic_secret" "aws_creds" {
  path = "aws-creds/aws"
}

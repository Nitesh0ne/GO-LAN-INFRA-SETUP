
provider "vault" {
  address = "http://127.0.0.1:8200"
}

data "vault_generic_secret" "aws_creds" {
  path = "aws_creds/aws"
}


provider "aws" {
  region     = "us-east-1"
  access_key = data.vault_generic_secret.aws_creds.data["access_key"]
  secret_key = data.vault_generic_secret.aws_creds.data["secret_key"]
}


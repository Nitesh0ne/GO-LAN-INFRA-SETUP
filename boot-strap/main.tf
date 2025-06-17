
provider "vault" {
  address = "http://127.0.0.1:8200"
}

data "vault_generic_secret" "aws_creds" {
  path = "aws-creds/aws"
}
provider "aws" {
  region     = "us-east-1"
  access_key = data.vault_generic_secret.aws_creds.data["access_key"]
  secret_key = data.vault_generic_secret.aws_creds.data["secret_key"]
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "niteshnepali.com.np"
  force_destroy = true

  tags = {
    Name = "Terraform_State_Bucket"
    prod = "dev.niteshnepali.com.np"
    dev = "prod.niteshnepali.com.np"
  }
}

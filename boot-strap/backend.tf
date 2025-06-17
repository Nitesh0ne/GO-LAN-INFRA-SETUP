terraform {
  backend "s3" {
    bucket         = "niteshnepali.com.np"
    key            = "bootstrap/terraform.tfstate"
    region         = "us-east-1"
    shared_credentials_files = ["d:\\CRED\\terraform_cred.txt"]

  }
}
resource "aws_s3_bucket" "s3_state_store" {
  bucket = var.bucket_name

  tags = {
    Name        = "dev-prod-bucket"
  }
}

resource "aws_s3_bucket_versioning" "versioning_enable" {
  bucket = aws_s3_bucket.s3_state_store.id
  versioning_configuration {
    status = "Enabled"
  }
}
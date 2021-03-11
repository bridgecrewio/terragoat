provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "storage" {
  bucket = var.bucket_name
  acl = "public-read"
}

variable "bucket_name" {
  description = "Name for your S3 bucket (globally unique)"
  type        = string
}

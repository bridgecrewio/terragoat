resource "aws_s3_bucket" "storage" {
  bucket = var.bucket_name
  acl = "public-read-write"
}

variable "bucket_name" {
  description = "Name for your S3 bucket (globally unique)"
  type        = string
  default     = "my_bucket"
}

resource "aws_s3_bucket" "blyat" {
  bucket        = "local.bucket_name"
  force_destroy = true
}

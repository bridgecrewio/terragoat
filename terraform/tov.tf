resource "aws_s3_bucket" "kisi_bucket" {
  bucket        = "local.bucket_name"
  force_destroy = true
}

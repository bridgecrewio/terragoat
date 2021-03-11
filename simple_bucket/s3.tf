resource "aws_s3_bucket" "storage" {
  bucket = "storage_bucket"
  acl = "public-read-write"
}

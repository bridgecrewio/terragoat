resource "aws_s3_bucket" "demos3" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Consume     = "do_not_use"
    do_not_use  = "true"
  }
}

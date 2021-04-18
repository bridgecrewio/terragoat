resource "aws_s3_bucket" "some_bucket" {
  bucket = "my-bucket-data-mor5"
  acl = "private"
  force_destroy = true
  arn = ""
  tags = {
    Name = "tag-data-mor5"
    Environment = "env"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = aws_s3_bucket.some_bucket.id
    target_prefix = "log/bucket"
  }
}

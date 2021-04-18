resource "aws_s3_bucket" "some_bucket" {
  bucket = "my-bucket-data-mor5"
  acl = "private"
  force_destroy = true
  arn = ""
  tags = {
    Name = "tag-data-mor5"
    Environment = "env"
  }
}

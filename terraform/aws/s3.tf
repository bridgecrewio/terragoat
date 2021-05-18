resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket = "${local.resource_prefix.value}-data-mor4"
  acl = "private"
  force_destroy = true
  arn = "arn:aws:s3:::619572639823-acme-dev-data-mor4"
  tags = {
    Name = "${local.resource_prefix.value}-data-mor4"
    Environment = local.resource_prefix.value
  }
}

resource "aws_s3_bucket" "data2" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  # checkov:skip=BC_AWS_S3_14:milkana test
  bucket = "${local.resource_prefix.value}-data-mor5"
  acl = "private"
  force_destroy = true
  arn = ""
  tags = {
    Name = "${local.resource_prefix.value}-data-mor5"
    Environment = local.resource_prefix.value
  }
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  # checkov:skip=BC_AWS_S3_14:mor test
  arn           = "arn:aws:s3:::619572639823-acme-dev-financials-test-mor4"
  bucket        = "${local.resource_prefix.value}-financials-test-mor4"
  acl           = "private"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-financials-test-mor4"
    Environment = local.resource_prefix.value
  }
}

resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket = "${local.resource_prefix.value}-data-science"
  acl    = "private"
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  force_destroy = true
  tags = {
    git_commit           = "f7ddd6967fd643104704d8744c5e5d97a1d213e4"
    git_file             = "s3.tf"
    git_last_modified_at = "2022-03-01 18:35:29"
    git_last_modified_by = "99741373+Winston1234567@users.noreply.github.com"
    git_modifiers        = "99741373+Winston1234567"
    git_org              = "Winston1234567"
    git_repo             = "terragoat"
    yor_trace            = "9a7c8788-5655-4708-bbc3-64ead9847f64"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "data_science" {
  bucket = aws_s3_bucket.data_science.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = "${aws_kms_key.logs_key.arn}"
      }
    }
  }
  force_destroy = true
  tags = merge({
    Name        = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
    }, {
    git_commit           = "f7ddd6967fd643104704d8744c5e5d97a1d213e4"
    git_file             = "s3.tf"
    git_last_modified_at = "2022-03-01 18:35:29"
    git_last_modified_by = "99741373+Winston1234567@users.noreply.github.com"
    git_modifiers        = "99741373+Winston1234567"
    git_org              = "Winston1234567"
    git_repo             = "terragoat"
    yor_trace            = "01946fe9-aae2-4c99-a975-e9b0d3a4696c"
  })
}

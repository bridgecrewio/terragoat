resource "aws_s3_bucket" "my_private_bucket" {
  #checkov:skip=CKV_AWS_144:Cross region replication not needed for this workload
  #checkov:skip=CKV_AWS_145:S3 SSE encryption sufficient for this workload
  bucket  = "my-private-bucket-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  acl           = "private"
  force_destroy = true

  versioning {
      enabled = true
  }

  logging {
      target_bucket = aws_s3_bucket.my_private_bucket_logs.id
      target_prefix = "log/"
  }

  server_side_encryption_configuration {
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "my_private_bucket" {
  bucket = aws_s3_bucket.my_private_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket" "my_private_bucket_logs" {
  #checkov:skip=CKV_AWS_18:No need to have access logs on the access logs
  #checkov:skip=CKV_AWS_144:Cross region replication not needed for this workload
  #checkov:skip=CKV_AWS_145:S3 SSE encryption sufficient for this workload
  bucket  = "my-private-bucket-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}-logs"
  acl           = "private"
  force_destroy = true

  versioning {
      enabled = true
  }

  server_side_encryption_configuration {
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
  }

  lifecycle_rule {
    id       = "s3_lifecycle_${data.aws_region.current.name}"
    enabled  = true

    prefix   = "/"

    expiration {
        days = 30
    }

    noncurrent_version_expiration {
        days = 30
    }
  }
}

resource "aws_s3_bucket_public_access_block" "my_private_bucket_logs" {
  bucket = aws_s3_bucket.my_private_bucket_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
}

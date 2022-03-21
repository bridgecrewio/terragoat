module s3_bucket {
  source = git::https://github.com/cloudposse/terraform-aws-s3-bucket.git
  acl                      = private
  enabled                  = true
  user_enabled             = true
  versioning_enabled       = false
  allowed_bucket_actions   = [s3:GetObject, s3:ListBucket, s3:GetBucketLocation]
  name                     = app
  stage                    = test
  namespace                = eg
}

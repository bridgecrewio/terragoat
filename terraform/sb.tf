
resource "aws_s3_bucket" "steven" {
   server_side_encryption_configuration {
     rule {
       apply_server_side_encryption_by_default {
         sse_algorithm = "aws:kms"
       }
     }
   }
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-steven"
  acl           = "private"
  force_destroy = true
  tags = merge({
    Name        = "${local.resource_prefix.value}-steven"
    Environment = local.resource_prefix.value
    }, {
  })

   versioning {
     enabled = true
   }
}
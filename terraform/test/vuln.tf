resource "aws_cloudtrail" "cloudtrail_vuln" {
  name                  = var.bucket
  s3_bucket_name        = var.bucket
  is_multi_region_trail = true


event_selector {
  include_management_events = true
  read_write_type           = "All"

  data_resource {
    type   = "AWS::S3::Object"
    values = [
        "arn:aws:s3:::snapdocs-storage/",
        "arn:aws:s3:::snapdocs-storage-backup/",
        "arn:aws:s3:::douglas-production/",
      ]
  }
}
}

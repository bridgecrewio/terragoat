resource "alicloud_actiontrail_trail" "fail" {
  # Action Trail not Logging for all regions
  # Action Trail not Logging for all events
  trail_name         = "action-trail"
  oss_write_role_arn = alicloud_ram_role.trail.arn
  oss_bucket_name    = alicloud_oss_bucket.trail.bucket
  event_rw           = "Read"
  trail_region       = "cn-hangzhou"
}

resource "alicloud_oss_bucket" "trail" {

}

resource "alicloud_ram_role" "trail" {
  name     = "trail"
  document = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "actiontrail.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
  force    = true
}
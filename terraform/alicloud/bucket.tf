resource "alicloud_oss_bucket" "bad_bucket" {
  # Public and writeable bucket 
  # Versioning enabled
  # Not Encrypted with a Customer Master Key and no Server side encryption
  # Doesn't have access logging enabled" 
  bucket = "wildwestfreeforall"
  acl    = "public-read-write"
}

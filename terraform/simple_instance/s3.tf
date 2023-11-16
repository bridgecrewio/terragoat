provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name        = "Docking Bay"
    Environment = "Dev1"
    yor_name    = "dockingbay"
    yor_trace   = "715734e3-9b8b-4c9e-99a8-3cf62d2f60a4"
  }
}

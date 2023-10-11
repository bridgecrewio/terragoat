provider "aws" {
  region = "eu-west-3"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name        = "Docking Bay"
    Environment = "Dev"
    yor_name    = "dockingbay"
    yor_trace   = "919a9836-5ea7-4841-94a2-4b6a322a1238"
  }
}

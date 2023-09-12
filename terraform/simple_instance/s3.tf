provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name        = "Docking Bay"
    Environment = "Dev"
    yor_name    = "dockingbay"
    yor_trace   = "8215da6e-dfa8-44b3-8d9c-c8c8c4fa14fd"
  }
}

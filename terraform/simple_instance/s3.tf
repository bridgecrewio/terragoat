provider "aws" {
  profile = "default"
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
  }
}


resource "aws_s3_bucket_versioning" "docking_bay" {
  bucket = aws_s3_bucket.docking_bay.id

  versioning_configuration {
    status = "Enabled"
  }


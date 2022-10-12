provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay1" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay1"
    Environment          = "Dev"
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "fce6d229469ce8eef15f1cda6beb80c522b56e0f"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-07-21 17:12:17"
    git_last_modified_by = "viacheslav.vasilyev@accenture.com"
    git_modifiers        = "viacheslav.vasilyev"
    git_org              = "mc-slava"
    git_repo             = "terragoat"
    yor_trace            = "fbedaf3b-8891-491b-90d4-01d2eac9898e"
  }
}

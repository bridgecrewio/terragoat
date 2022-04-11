provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "016721161628719e39a554fed21d6d00dd33daff"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-04-11 21:42:55"
    git_last_modified_by = "rbaccus@outlook.com"
    git_modifiers        = "rbaccus"
    git_org              = "rbaccus"
    git_repo             = "terragoat"
    yor_trace            = "ff32391e-ba8d-497e-bbf6-70f384e2c080"
  }
}
provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "858c9d0f78c476f655ed77b930d5a5a65f9f43c3"
    git_file             = "terraform/aws/s3demo.tf"
    git_last_modified_at = "2022-03-21 19:42:07"
    git_last_modified_by = "92009631+bphanpcs@users.noreply.github.com"
    git_modifiers        = "92009631+bphanpcs"
    git_org              = "bphanpcs"
    git_repo             = "terragoat"
    yor_trace            = "87367107-285a-49b4-878a-1bdbacff0ea6"
  }
}

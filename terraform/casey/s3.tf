provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "72608c8feb565efa038a0316b4144372729677cd"
    git_file             = "terraform/casey/s3.tf"
    git_last_modified_at = "2022-01-26 00:09:40"
    git_last_modified_by = "90857961+caswalker@users.noreply.github.com"
    git_modifiers        = "90857961+caswalker"
    git_org              = "caswalker"
    git_repo             = "terragoat"
    yor_trace            = "aae2eb98-9e41-416e-be43-53f8b3225128"
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "f63f0d79a2f86be1dbb2e6e224e3d38c19988c5e"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-06-23 17:33:57"
    git_last_modified_by = "55289436+cah-douglas-short@users.noreply.github.com"
    git_modifiers        = "55289436+cah-douglas-short"
    git_org              = "cah-douglas-short"
    git_repo             = "terragoat"
    yor_trace            = "5698d159-a19f-40bb-b9f0-f25f4932f3d0"
  }
}

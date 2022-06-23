provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "881d232add2b11aee6a8a64d88caae76e28a357b"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-06-23 18:13:24"
    git_last_modified_by = "55289436+cah-douglas-short@users.noreply.github.com"
    git_modifiers        = "55289436+cah-douglas-short"
    git_org              = "cah-douglas-short"
    git_repo             = "terragoat"
    yor_trace            = "31dab1cf-d8cb-4cbb-8df6-e045332830bf"
  }
}

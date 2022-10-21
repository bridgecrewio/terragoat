provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "a48a1b9faaa7e1e2ea83a90224d04bcdb934e7c0"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-10-21 17:50:04"
    git_last_modified_by = "zcahill@users.noreply.github.com"
    git_modifiers        = "zcahill"
    git_org              = "zcahill"
    git_repo             = "terragoat"
    yor_trace            = "a8858b0d-61e8-48c7-af8b-f9a3c7aee3e4"
  }
}

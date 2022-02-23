provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "7af857a31b28aba9f7b6b451aec76d3e92e532c7"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-02-23 18:28:12"
    git_last_modified_by = "OptimAdam@hotmail.com"
    git_modifiers        = "OptimAdam"
    git_org              = "OptimAdam"
    git_repo             = "terragoat"
    yor_trace            = "df9d3dc2-ada1-40bd-800f-657d448ad01a"
  }
}

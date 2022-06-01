provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "2167576335dff7030188f3b6d362c0bb3a63f079"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-05-27 18:38:59"
    git_last_modified_by = "102304738+abheemarao@users.noreply.github.com"
    git_modifiers        = "102304738+abheemarao"
    git_org              = "abheemarao"
    git_repo             = "terragoat"
    yor_trace            = "0cccd15f-4c11-4a8b-882a-8fb05882e5f8"
  }
}

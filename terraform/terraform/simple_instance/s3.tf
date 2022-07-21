provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "993c4f6ac249516787ac93ae15a30e48582a4cb6"
    git_file             = "terraform/terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-07-21 17:06:49"
    git_last_modified_by = "108514953+mc-slava@users.noreply.github.com"
    git_modifiers        = "108514953+mc-slava"
    git_org              = "mc-slava"
    git_repo             = "terragoat"
    yor_trace            = "6d03bc9f-65ef-4c5e-9db2-c11e49c11af5"
  }
}

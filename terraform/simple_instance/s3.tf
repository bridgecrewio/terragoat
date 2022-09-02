provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "cdcbf195c56bff401c3b221c6b59644b940f48ca"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-09-02 09:34:48"
    git_last_modified_by = "brainboyrichmond@gmail.com"
    git_modifiers        = "brainboyrichmond"
    git_org              = "njokuifeanyigerald"
    git_repo             = "terragoat"
    yor_trace            = "b5f2809f-090b-4c69-90fc-98ecc1419c37"
  }
}

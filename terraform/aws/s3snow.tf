provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay1" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay1"
    Environment          = "Dev"
    git_commit           = "a97689cfe87bb753394cf62def06586f5446c2ea"
    git_file             = "terraform/aws/s3snow.tf"
    git_last_modified_at = "2022-10-12 20:49:31"
    git_last_modified_by = "102304738+abheemarao@users.noreply.github.com"
    git_modifiers        = "102304738+abheemarao"
    git_org              = "abheemarao"
    git_repo             = "terragoat"
    yor_trace            = "41a576b5-60e3-49cd-86c1-c4425c610d2f"
  }
}

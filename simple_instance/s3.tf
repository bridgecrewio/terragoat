provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "5d18ba0565ec0aaf6e3f16abde17597e868eb250"
    git_file             = "simple_instance/s3.tf"
    git_last_modified_at = "2022-06-01 17:01:09"
    git_last_modified_by = "102304738+abheemarao@users.noreply.github.com"
    git_modifiers        = "102304738+abheemarao"
    git_org              = "abheemarao"
    git_repo             = "terragoat"
    yor_trace            = "21df2353-ce7a-4919-8b37-b80b34714835"
  }
}

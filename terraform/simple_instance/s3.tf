provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "928adc70a6ea31e6fa4be5bfb0bf5baa0305bf44"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-05-19 01:37:24"
    git_last_modified_by = "arielsalvo@users.noreply.github.com"
    git_modifiers        = "arielsalvo"
    git_org              = "arielsalvo"
    git_repo             = "terragoat"
    yor_name             = "dockingbay"
    yor_trace            = "a9c6c91f-4473-478c-adfd-35cd2b0a1ce7"
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "a9b8a1d4e6c33f46eb6dbea447d3d5b15044d97e"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-01-17 12:20:43"
    git_last_modified_by = "120496483+jmagee70@users.noreply.github.com"
    git_modifiers        = "120496483+jmagee70"
    git_org              = "jmagee70"
    git_repo             = "terragoatCCS"
    yor_trace            = "10eb6a56-90fb-4f19-886f-633cb8f90fd4"
  }
}

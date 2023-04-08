provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "c36914db47f6a44614f36d80a1cdd5162bcd81b3"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-04-08 09:31:38"
    git_last_modified_by = "rob.langford1@gmail.com"
    git_modifiers        = "rob.langford1"
    git_org              = "roblangford"
    git_repo             = "terragoat"
    yor_trace            = "95ddef9c-53ef-4ca6-8d01-12fce373e0da"
  }
}

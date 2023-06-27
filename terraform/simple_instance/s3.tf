provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "92d004a8e27837700524fff07f76ceaa5df43dd8"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-06-27 14:01:22"
    git_last_modified_by = "68172026+yogesh-mishra@users.noreply.github.com"
    git_modifiers        = "68172026+yogesh-mishra"
    git_org              = "yogesh-mishra"
    git_repo             = "terragoat"
    yor_name             = "dockingbay"
    yor_trace            = "9f0d07c7-8ced-4241-b980-6346a68b0fb6"
  }
}

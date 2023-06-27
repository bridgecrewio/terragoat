provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "ec24afaf0b35090b5a9238b6671a8563d0ba7fb3"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-06-27 22:03:17"
    git_last_modified_by = "60461497+josh-dev-l@users.noreply.github.com"
    git_modifiers        = "60461497+josh-dev-l"
    git_org              = "josh-dev-l"
    git_repo             = "terragoat"
    yor_name             = "dockingbay"
    yor_trace            = "b519d337-5b3b-498a-9232-b13572f3ff87"
  }
}

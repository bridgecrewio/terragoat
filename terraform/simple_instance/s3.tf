provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "ef39c97a26a2bd427c3e16af486d112ab86132ef"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-06-27 21:49:26"
    git_last_modified_by = "60461497+josh-dev-l@users.noreply.github.com"
    git_modifiers        = "60461497+josh-dev-l"
    git_org              = "josh-dev-l"
    git_repo             = "terragoat"
    yor_name             = "dockingbay"
    yor_trace            = "c8907279-e170-45f7-bd11-ea6d9b333b0b"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    yor_name             = "dockingbay"
    yor_trace            = "8215da6e-dfa8-44b3-8d9c-c8c8c4fa14fd"
    git_commit           = "4d97d59e2d0cf70d8e0cf4a8fa04788bbf4ebb4f"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-09-12 18:40:52"
    git_last_modified_by = "57599263+kikeman26@users.noreply.github.com"
    git_modifiers        = "57599263+kikeman26"
    git_org              = "kikeman26"
    git_repo             = "terragoat"
  }
}

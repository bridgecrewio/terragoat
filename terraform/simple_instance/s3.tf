provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Day"
    Environment          = "Dev"
    git_commit           = "db9f3f7953d0bad5fa6e5ac7012d8eb8957a5286"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-07-06 21:18:21"
    git_last_modified_by = "138732993+hacktopown@users.noreply.github.com"
    git_modifiers        = "138732993+hacktopown"
    git_org              = "hacktopown"
    git_repo             = "terragoat"
    yor_name             = "dockingbay"
    yor_trace            = "ce265a3d-111b-450c-a570-c226483748ff"
  }
}

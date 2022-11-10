provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "90e58075fedc68cfc4c9fa38c9f6f14ddce09f35"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-11-10 17:40:32"
    git_last_modified_by = "1662976+x-a-n-d-e-r-k@users.noreply.github.com"
    git_modifiers        = "1662976+x-a-n-d-e-r-k"
    git_org              = "x-a-n-d-e-r-k"
    git_repo             = "terragoat"
    yor_trace            = "05abeb05-e8cc-4a6a-a921-e7934d02700f"
  }
}

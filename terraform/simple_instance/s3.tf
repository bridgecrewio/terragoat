provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "99b7ba09f032262bc5aec30a9d0c2cb408db4bff"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2023-05-18 18:43:51"
    git_last_modified_by = "52509683+captain-seasalt@users.noreply.github.com"
    git_modifiers        = "52509683+captain-seasalt"
    git_org              = "captain-seasalt"
    git_repo             = "terragoat"
    yor_name             = "dockingbay"
    yor_trace            = "f801f23f-86e8-4adc-b317-4aadc177be43"
  }
}

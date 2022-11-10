provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dockingbay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "0fd883ebc9b1df2018c1959aac7547793602af88"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-11-10 17:41:36"
    git_last_modified_by = "1662976+x-a-n-d-e-r-k@users.noreply.github.com"
    git_modifiers        = "1662976+x-a-n-d-e-r-k"
    git_org              = "x-a-n-d-e-r-k"
    git_repo             = "terragoat"
    yor_trace            = "8fd575aa-7a09-4e0b-b7b9-54561e835d9b"
  }
}

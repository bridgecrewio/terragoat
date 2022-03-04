provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "df8d95e19027d2f9893720ea924fe43bac2475db"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-03-04 08:58:32"
    git_last_modified_by = "69608717+panyergo@users.noreply.github.com"
    git_modifiers        = "69608717+panyergo"
    git_org              = "panyergo"
    git_repo             = "terragoat"
    yor_trace            = "d30e4c61-6ad5-456c-a471-27772b2b5d63"
  }
}

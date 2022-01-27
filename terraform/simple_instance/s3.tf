provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "eca85f5081c525440c88cb8d12f4cdbd8455a511"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-01-27 18:26:20"
    git_last_modified_by = "49070697+Niackyballz@users.noreply.github.com"
    git_modifiers        = "49070697+Niackyballz"
    git_org              = "Niackyballz"
    git_repo             = "terragoat"
    yor_trace            = "efaa70fe-924d-4923-9b74-87a7d9ba6745"
  }
}

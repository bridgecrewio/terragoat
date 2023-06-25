provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "prismaclouds3" {
  bucket_prefix = "prismacloud-s3"

  tags = {
    Name                 = "Prisma Cloud"
    Environment          = "Dev"
  }
}

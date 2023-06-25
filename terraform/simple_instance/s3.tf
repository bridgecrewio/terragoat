provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "prismaclouds3" {
  bucket_prefix = "prismacloud-s3"

  tags = {
    Name        = "Prisma Cloud"
    Environment = "Dev"
    yor_trace   = "60eeb16c-a434-48b7-b367-8c5c7dbd1821"
  }
}
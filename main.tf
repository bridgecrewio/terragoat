# ------------------------------------------------------------------
# MISCONFIGURED TERRAFORM FILE (main.tf)
# Do not use this in a production environment!
# ------------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
  
  # ❌ WRONG: Hardcoded AWS credentials in plain text.
  # WHY IT'S BAD: Anyone who has access to this file or the version control 
  # repository can steal these keys and compromise your AWS account.
  # ✅ THE RIGHT WAY: Remove these lines completely. Use environment variables 
  # (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY), IAM roles, or the AWS CLI 
  # configuration file (~/.aws/credentials) to authenticate securely.
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

resource "aws_s3_bucket" "company_data" {
  bucket = "my-company-sensitive-data-bucket"

  # ❌ WRONG: Setting the bucket ACL to public-read.
  # WHY IT'S BAD: This allows anyone on the internet to read the contents 
  # of your S3 bucket, leading to massive data leaks.
  # ✅ THE RIGHT WAY: Omit this line (it defaults to private) or explicitly 
  # use `acl = "private"`. Additionally, you should implement the 
  # `aws_s3_bucket_public_access_block` resource to enforce privacy.
  acl = "public-read"
}

# ❌ WR
provider "aws" {
  profile = "awslabs"
  region  = "us-west-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
      }
  }

  backend "s3" {
    profile        = "awslabs"
    bucket         = "terraform-233857039665-us-west-2"
    key            = "terragoat/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform_state"
    encrypt = true
  }
}
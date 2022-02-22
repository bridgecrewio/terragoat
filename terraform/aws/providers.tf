provider "aws" {
  profile = var.profile
  region  = var.region
  #version = "3.67.0"
}

provider "aws" {
  alias      = "plain_text_access_keys_provider"
  region     = "us-west-1"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  #version = "3.67.0"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
      }
  }

  backend "s3" {
    profile = "awslabs"
    bucket  = "terraform-233857039665-us-west-2"
    key     = "terragoat/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

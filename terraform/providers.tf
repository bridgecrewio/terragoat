
provider "aws" {
  profile = var.profile
  region  = var.region
}

terraform {
  backend "s3" {
    encrypt = true
  }
}

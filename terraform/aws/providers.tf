
provider "aws" {
  profile = var.profile
  region  = var.region
}

provider "aws" {
  alias      = "plain_text_access_keys_provider"
  region     = "us-west-1"
  #checkov:skip=CKV_AWS_41
  access_key = "AKIAIOSFODNN7EXAMPLE"
  #checkov:skip=CKV_AWS_41
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

terraform {
  backend "s3" {
    encrypt = true
  }
}

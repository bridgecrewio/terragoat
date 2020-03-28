
data "aws_caller_identity" "current" {}

variable "company_name" {
  default = "acme"
}

variable "environment_prefix" {
  default = "dev"
}

locals {
  resource_prefix = {
    value = "${data.aws_caller_identity.current.account_id}-${var.company_name}-${var.environment_prefix}"
  }
}

variable "region" {
  default = "us-west-2"
}

variable "profile" {
  default = "default"
}
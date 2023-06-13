
data "aws_caller_identity" "current" {}

variable "company_name" {
  default = "acme"
}

variable "environment" {
  default = "dev"
}

locals {
  resource_prefix = {
    value = "${data.aws_caller_identity.current.account_id}-${var.company_name}-${var.environment}"
  }
}

data "aws_ami" "ubuntu-linux-2004" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-*"]
  }
 
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-west-2"
}

# variable ami {
#   type    = string
#   default = "ami-09988af04120b3591"
# }

variable "dbname" {
  type        = string
  description = "Name of the Database"
  default     = "db1"
}

variable "password" {
  type        = string
  description = "Database password"
  default     = "Aa1234321Bb"
}

variable "neptune-dbname" {
  type        = string
  description = "Name of the Neptune graph database"
  default     = "neptunedb1"
}

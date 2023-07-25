# General
variable "workspace_account" {}
variable "workspace_environment" {}
variable "app_name" {
  default = "iac-scan"
}

variable "region_abbr" {
  type = map(any)
  default = {
    "us-east-1"    = "ue1"
    "us-east-2"    = "ue2"
    "us-west-1"    = "uw1"
    "us-west-2"    = "uw2"
    "eu-central-1" = "ec1"
    "eu-west-1"    = "ew1"
    "eu-west-2"    = "ew2"
    "eu-west-3"    = "ew3"
    "eu-north-1"   = "en1"
  }
}

# Autoscaling Group

variable "instance_type" {
  default = "m5.xlarge"
}

variable "asg_max_size" {
  default = "3"
}

variable "asg_min_size" {
  default = "3"
}

variable "asg_desired_capacity" {
  default = "3"
}

variable "key_name" {
  default = "dso-staging-key"
}

# Tags
variable "tag_team" {
  type    = string
  default = "IO"
}

variable "tag_cost_center" {
  type    = string
  default = "ENG"
}

variable "tag_cost_code" {
  type    = string
  default = "SP"
}

variable "metadata_options" {
  description = "The metadata options of the instances"
  type        = map(string)
  default = {
    http_put_response_hop_limit = 2
  }
}

variable "akeyless_access_id" {
  type = string
}

variable "akeyless_access_key" {
  type = string
}

variable "security_sso_role" {
  type    = string
}

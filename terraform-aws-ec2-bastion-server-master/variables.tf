variable "enabled" {
  type        = bool
  default     = true
  description = "When disabled, module will not create any resources"
}

variable "namespace" {
  description = "Namespace (e.g. `eg` or `cp`)"
  type        = string
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = string
}

variable "name" {
  description = "Name  (e.g. `app` or `bastion`)"
  type        = string
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}

variable "zone_id" {
  type        = string
  default     = ""
  description = "Route53 DNS Zone ID"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Elastic cache instance type"
}

variable "ami" {
  type        = string
  default     = "ami-efd0428f"
  description = "AMI to use"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnets" {
  type        = list(string)
  description = "AWS subnet IDs"
}

variable "user_data" {
  type        = list(string)
  default     = []
  description = "User data content"
}

variable "key_name" {
  type        = string
  default     = ""
  description = "Key name"
}

variable "ssh_user" {
  type        = string
  description = "Default SSH user for this AMI. e.g. `ec2user` for Amazon Linux and `ubuntu` for Ubuntu systems"
}

variable "ingress_security_groups" {
  type        = list(string)
  description = "AWS security group IDs allowed ingress to instance"
  default     = []
}

variable "security_groups" {
  type        = list(string)
  description = "AWS security group IDs associated with instance"
  default     = []
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "A list of CIDR blocks allowed to connect"

  default = [
    "0.0.0.0/0",
  ]
}

variable "root_block_device_encrypted" {
  type        = bool
  default     = false
  description = "Whether to encrypt the root block device"
}

variable "root_block_device_volume_size" {
  type        = number
  default     = 8
  description = "The volume size (in GiB) to provision for the root block device. It cannot be smaller than the AMI it refers to."
}

variable "metadata_http_endpoint_enabled" {
  type        = bool
  default     = true
  description = "Whether the metadata service is available"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  default     = 1
  description = "The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests."
}

variable "metadata_http_tokens_required" {
  type        = bool
  default     = false
  description = "Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2."
}

variable "associate_public_ip_address" {
  type        = bool
  default     = true
  description = "Whether to associate a public IP to the instance."
}

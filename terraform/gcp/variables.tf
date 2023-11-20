variable "credentials_path" {
  type        = string
  description = "Path to credentials file"
}

variable "project" {
  type        = string
  description = "The GCP project to be deployed to"
}

variable "region" {
  default = "europe-west2"
  type    = string
}

variable "environment" {
  default     = "dev"
  description = "The environment name"
}

variable "location" {
  default = "europe-west2"
  type    = string
}
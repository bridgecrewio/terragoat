variable "subscription_id" {
  type        = string
  description = "The subscription ID to be scanned"
  default     = null
}

variable "location" {
  type    = string
  default = "East US"
}

variable "environment" {
  default     = "dev"
  description = "Must be all lowercase letters or numbers"
}

variable "test_client_secret_value" {
  default     = "Q598Q~cGWt_XhN1x9oMEn7z3TsG9Ph4H5qBU~aio"
  type = string
}

variable "test_client_secret_id" {
  default     = "80bdb59f-288f-4cb3-ae6a-3d9a979e6a6e"
  type = string
}

resource "oci_objectstorage_bucket" "secretsquirrel" {
  # bucket can't emit object events
  # Storage hasn't versioning enabled
  # Storage isn't encrypted with Customer Managed Key
  # Object Storage is Public"
  compartment_id        = oci_identity_compartment.tf-compartment.id
  name                  = "myreallysecretstore"
  namespace             = data.oci_objectstorage_namespace.example.namespace
  object_events_enabled = false
  access_type           = "ObjectRead"
  metadata              = { "data" = "Blockofdata" }
  storage_tier          = "Standard"
}

resource "oci_identity_compartment" "tf-compartment" {
  compartment_id = var.tenancy_id
  description    = "Compartment for Terraform resources."
  name           = "third-compartment"
  enable_delete  = true
}

data "oci_objectstorage_namespace" "example" {
  compartment_id = oci_identity_compartment.tf-compartment.id
}

variable "tenancy_id" {
  description = "value supplied by env var"
  default     = ""
}

provider "oci" {
  #these to be provided by env vars
  # private_key_path
  # fingerprint
  # tenancy_ocid 
  # user_ocid   
  region = "uk-london-1"
}

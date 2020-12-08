resource "aws_kms_key" "logs_key" {
  # key does not have rotation enabled
  description = "${local.resource_prefix.value}-logs bucket key"

  deletion_window_in_days = 7
}

resource "aws_kms_alias" "logs_key_alias" {
  name          = "alias/${local.resource_prefix.value}-logs-bucket-key"
  target_key_id = "${aws_kms_key.logs_key.key_id}"
}


resource "aws_kms_key" "customer_key" {
  # key does not have rotation enabled
  description = "${local.resource_prefix.value}-customer bucket key"
  enable_key_rotation = var.enable_key_rotation

  deletion_window_in_days = 7
}

resource "aws_kms_alias" "customer_key_alias" {
  name          = "alias/${local.resource_prefix.value}-customer-bucket-key"
  target_key_id = "${aws_kms_key.customer_key.key_id}"
}

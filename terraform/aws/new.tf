resource "aws_kms_key" "logs_key" {
  # key does not have rotation enabled
  description = "${local.resource_prefix.value}-logs bucket key"

  deletion_window_in_days = 7
  tags = {
    git_commit           = "c95b9b07175ef0cd85419239709bbf3481943f78"
    git_file             = "terraform/aws/new.tf"
    git_last_modified_at = "2021-12-14 23:57:11"
    git_last_modified_by = "90857961+caswalker@users.noreply.github.com"
    git_modifiers        = "90857961+caswalker"
    git_org              = "caswalker"
    git_repo             = "terragoat"
    yor_trace            = "cd8fa2a7-4868-4cd1-993d-da4644808ce5"
  }
}

resource "aws_kms_alias" "logs_key_alias" {
  name          = "alias/${local.resource_prefix.value}-logs-bucket-key"
  target_key_id = "${aws_kms_key.logs_key.key_id}"
}

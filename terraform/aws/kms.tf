resource "aws_kms_key" "logs_key" {
  # key does not have rotation enabled
  description = "${local.resource_prefix.value}-logs bucket key"

  enable_key_rotation = true

  deletion_window_in_days = 7
  tags = {
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/aws/kms.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "bridgecrewio"
    git_repo             = "terragoat"
    yor_trace            = "cd8fa2a7-4868-4cd1-993d-da4644808ce5"
  }
}

resource "aws_kms_alias" "logs_key_alias" {
  name          = "alias/${local.resource_prefix.value}-logs-bucket-key"
  target_key_id = aws_kms_key.logs_key.key_id
}

resource "aws_kms_key" "security_key" {
  description             = "${local.resource_prefix.value}-security key"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    git_commit           = "8e336fa"
    git_file             = "terraform/aws/kms.tf"
    git_last_modified_at = "2026-07-10 00:00:00"
    git_last_modified_by = "GitHub Copilot"
    git_modifiers        = "copilot"
    git_org              = "bridgecrewio"
    git_repo             = "terragoat"
    yor_trace            = "a3a1c7f4-8c22-44f3-bfd9-0b9b8d0f1e11"
  }
}

resource "aws_kms_alias" "security_key_alias" {
  name          = "alias/${local.resource_prefix.value}-security-key"
  target_key_id = aws_kms_key.security_key.key_id
}

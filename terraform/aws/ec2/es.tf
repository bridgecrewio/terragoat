resource "aws_elasticsearch_domain" "monitoring-framework" {
  domain_name           = "tg-${var.environment}-es"
  elasticsearch_version = "2.3"

  cluster_config {
    instance_type            = "t2.small.elasticsearch"
    instance_count           = 1
    dedicated_master_enabled = false
    dedicated_master_type    = "m4.large.elasticsearch"
    dedicated_master_count   = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 30
  }
  tags = {
    git_commit           = "9f9ca61e9f76cad3f74c91dce8ad34ecfa248b35"
    git_file             = "terraform/aws/ec2/es.tf"
    git_last_modified_at = "2023-06-11 04:14:04"
    git_last_modified_by = "itgeek@email.com"
    git_modifiers        = "itgeek"
    git_org              = "smakineni-panw"
    git_repo             = "terragoat-vuln"
    yor_trace            = "95131dec-d7c9-49bb-9aff-eb0e2736603b"
    yor_name             = "monitoring-framework"
  }
}

data aws_iam_policy_document "policy" {
  statement {
    actions = ["es:*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["*"]
  }
}

resource "aws_elasticsearch_domain_policy" "monitoring-framework-policy" {
  domain_name     = aws_elasticsearch_domain.monitoring-framework.domain_name
  access_policies = data.aws_iam_policy_document.policy.json
}

module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.19.2"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

resource "aws_iam_instance_profile" "default" {
  count = var.enabled ? 1 : 0
  name  = module.label.id
  role  = aws_iam_role.default[0].name
  tags = {
    git_commit           = "f1a3726cb53d99856f4e4a77388f3756ba9969ce"
    git_file             = "terraform-aws-ec2-bastion-server-master/main.tf"
    git_last_modified_at = "2020-11-09 16:45:37"
    git_last_modified_by = "68634672+guyeisenkot@users.noreply.github.com"
    git_modifiers        = "68634672+guyeisenkot"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "a41d0fab-043b-4f57-936f-8fe874c87502"
  }
}

resource "aws_iam_role" "default" {
  count = var.enabled ? 1 : 0
  name  = module.label.id
  path  = "/"

  assume_role_policy = data.aws_iam_policy_document.default.json
  tags = {
    git_commit           = "f1a3726cb53d99856f4e4a77388f3756ba9969ce"
    git_file             = "terraform-aws-ec2-bastion-server-master/main.tf"
    git_last_modified_at = "2020-11-09 16:45:37"
    git_last_modified_by = "68634672+guyeisenkot@users.noreply.github.com"
    git_modifiers        = "68634672+guyeisenkot"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "77698d91-87d6-499e-b642-80afec212245"
  }
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_security_group" "default" {
  count       = var.enabled ? 1 : 0
  name        = module.label.id
  vpc_id      = var.vpc_id
  description = "Bastion security group (only SSH inbound access is allowed)"

  tags                 = module.label.
  git_commit           = "f1a3726cb53d99856f4e4a77388f3756ba9969ce"
  git_file             = "terraform-aws-ec2-bastion-server-master/main.tf"
  git_last_modified_at = "2020-11-09 16:45:37"
  git_last_modified_by = "68634672+guyeisenkot@users.noreply.github.com"
  git_modifiers        = "68634672+guyeisenkot"
  git_org              = "try-bridgecrew"
  git_repo             = "terragoat"
  yor_trace            = "9e8e60de-9451-49a8-99fa-47b0ec2d5385"
  tags

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    security_groups = var.ingress_security_groups
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "domain" {
  count   = var.enabled && var.zone_id != "" ? 1 : 0
  zone_id = var.zone_id
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    user_data       = join("\n", var.user_data)
    welcome_message = var.stage
    hostname        = "${var.name}.${join("", data.aws_route53_zone.domain.*.name)}"
    search_domains  = join("", data.aws_route53_zone.domain.*.name)
    ssh_user        = var.ssh_user
  }
}

resource "aws_instance" "default" {
  count         = var.enabled ? 1 : 0
  ami           = var.ami
  instance_type = var.instance_type

  user_data = data.template_file.user_data.rendered

  vpc_security_group_ids = compact(concat(aws_security_group.default.*.id, var.security_groups))

  iam_instance_profile        = aws_iam_instance_profile.default[0].name
  associate_public_ip_address = var.associate_public_ip_address

  key_name = var.key_name

  subnet_id = var.subnets[0]

  tags                 = module.label.
  git_commit           = "f1a3726cb53d99856f4e4a77388f3756ba9969ce"
  git_file             = "terraform-aws-ec2-bastion-server-master/main.tf"
  git_last_modified_at = "2020-11-09 16:45:37"
  git_last_modified_by = "68634672+guyeisenkot@users.noreply.github.com"
  git_modifiers        = "68634672+guyeisenkot"
  git_org              = "try-bridgecrew"
  git_repo             = "terragoat"
  yor_trace            = "86643236-5fa9-48c8-8904-61441a419264"
  tags

  metadata_options {
    http_endpoint               = (var.metadata_http_endpoint_enabled) ? "enabled" : "disabled"
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = (var.metadata_http_tokens_required) ? "required" : "optional"
  }

  root_block_device {
    encrypted   = var.root_block_device_encrypted
    volume_size = var.root_block_device_volume_size
  }
}

module "dns" {
  source  = "git::https://github.com/cloudposse/terraform-aws-route53-cluster-hostname.git?ref=tags/0.7.0"
  enabled = var.enabled && var.zone_id != "" ? true : false
  name    = var.name
  zone_id = var.zone_id
  ttl     = 60
  records = aws_instance.default.*.public_dns
}

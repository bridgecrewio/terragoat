resource aws_ecr_repository "repository" {
  name                 = "${local.resource_prefix.value}-repository"
  image_tag_mutability = "MUTABLE"

  tags = merge({
    Name = "${local.resource_prefix.value}-repository"
    }, {
    git_commit           = "9f9ca61e9f76cad3f74c91dce8ad34ecfa248b35"
    git_file             = "terraform/aws/ec2/ecr.tf"
    git_last_modified_at = "2023-06-11 04:14:04"
    git_last_modified_by = "itgeek@email.com"
    git_modifiers        = "itgeek"
    git_org              = "smakineni-panw"
    git_repo             = "terragoat-vuln"
    yor_trace            = "7a3ec657-fa54-4aa2-8467-5d08d6c90bc2"
    }, {
    yor_name = "repository"
  })
}

locals {
  docker_image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${aws_ecr_repository.repository.name}"
}


resource null_resource "push_image" {
  provisioner "local-exec" {
    working_dir = "${path.module}/resources"
    command     = <<BASH
    aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com
    docker build -t ${aws_ecr_repository.repository.name} .
    docker tag ${aws_ecr_repository.repository.name} ${local.docker_image}
    docker push ${local.docker_image}
    BASH
  }
}
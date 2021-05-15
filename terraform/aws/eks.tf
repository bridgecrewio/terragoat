locals {
  eks_name = {
    value = "${local.resource_prefix.value}-eks"
  }
}

data aws_iam_policy_document "iam_policy_eks" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource aws_iam_role "iam_for_eks" {
  name               = "${local.resource_prefix.value}-iam-for-eks"
  assume_role_policy = data.aws_iam_policy_document.iam_policy_eks.json
  tags = {
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/aws/eks.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "bd7adb80-641d-458c-afcb-7444f6cf62c9"
  }
}

resource aws_iam_role_policy_attachment "policy_attachment-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_for_eks.name
}

resource aws_iam_role_policy_attachment "policy_attachment-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.iam_for_eks.name
}

resource aws_vpc "eks_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name                 = "${local.resource_prefix.value}-eks-vpc"
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/aws/eks.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "c8a9e1c6-7d3e-4082-bac8-4af8695b7482"
  }
}

resource aws_subnet "eks_subnet1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.10.10.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name                                             = "${local.resource_prefix.value}-eks-subnet"
    "kubernetes.io/cluster/${local.eks_name.value}"  = "shared"
    git_commit                                       = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file                                         = "terraform/aws/eks.tf"
    git_last_modified_at                             = "2020-06-16 14:46:24"
    git_last_modified_by                             = "nimrodkor@gmail.com"
    git_modifiers                                    = "nimrodkor"
    git_org                                          = "try-bridgecrew"
    git_repo                                         = "terragoat"
    "kubernetes.io/cluster/$${local.eks_name.value}" = "shared"
    yor_trace                                        = "52b1253b-b6b6-4f12-8537-e37996f2064b"
  }
}

resource aws_subnet "eks_subnet2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.10.11.0/24"
  availability_zone       = var.availability_zone2
  map_public_ip_on_launch = true
  tags = {
    Name                                             = "${local.resource_prefix.value}-eks-subnet2"
    "kubernetes.io/cluster/${local.eks_name.value}"  = "shared"
    git_commit                                       = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file                                         = "terraform/aws/eks.tf"
    git_last_modified_at                             = "2020-06-16 14:46:24"
    git_last_modified_by                             = "nimrodkor@gmail.com"
    git_modifiers                                    = "nimrodkor"
    git_org                                          = "try-bridgecrew"
    git_repo                                         = "terragoat"
    "kubernetes.io/cluster/$${local.eks_name.value}" = "shared"
    yor_trace                                        = "76599b94-8cbc-430e-9dd5-92efeda9cea1"
  }
}

resource aws_eks_cluster "eks_cluster" {
  name     = local.eks_name.value
  role_arn = "${aws_iam_role.iam_for_eks.arn}"

  vpc_config {
    endpoint_private_access = true
    subnet_ids              = ["${aws_subnet.eks_subnet1.id}", "${aws_subnet.eks_subnet2.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.policy_attachment-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.policy_attachment-AmazonEKSServicePolicy",
  ]
  tags = {
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/aws/eks.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "try-bridgecrew"
    git_repo             = "terragoat"
    yor_trace            = "939faa1c-a25b-4d31-ad75-b713c840fe87"
  }
}

output "endpoint" {
  value = "${aws_eks_cluster.eks_cluster.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.eks_cluster.certificate_authority.0.data}"
}

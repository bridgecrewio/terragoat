resource "aws_iam_role" "iam_for_eks" {
  name = "${local.resource_prefix.value}-iam-for-eks"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "policy_attachment-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.iam_for_eks.name}"
}

resource "aws_iam_role_policy_attachment" "policy_attachment-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.iam_for_eks.name}"
}

resource "aws_vpc" "primary_eks_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${local.resource_prefix.value}-eks-vpc"
  }
}

resource "aws_subnet" "primary_eks_subnet1" {
  vpc_id                  = aws_vpc.primary_eks_vpc.id
  cidr_block              = "10.10.10.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.resource_prefix.value}-eks-subnet"
  }
}

resource "aws_subnet" "primary_eks_subnet2" {
  vpc_id                  = aws_vpc.primary_eks_vpc.id
  cidr_block              = "10.10.11.0/24"
  availability_zone       = var.availability_zone2
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.resource_prefix.value}-eks-subnet2"
  }
}

resource "aws_eks_cluster" "primary_eks" {
  name     = "${local.resource_prefix.value}-primary-eks"
  role_arn = "${aws_iam_role.iam_for_eks.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.primary_eks_subnet1.id}", "${aws_subnet.primary_eks_subnet2.id}"]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    "aws_iam_role_policy_attachment.policy_attachment-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.policy_attachment-AmazonEKSServicePolicy",
  ]
}

output "endpoint" {
  value = "${aws_eks_cluster.primary_eks.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.primary_eks.certificate_authority.0.data}"
}
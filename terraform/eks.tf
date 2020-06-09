data aws_iam_policy_document "iam_policy_eks" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
        type        = "Service"
        identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource aws_iam_role "iam_for_eks" {
  name = "${local.resource_prefix.value}-iam-for-eks"
  assume_role_policy = data.aws_iam_policy_document.iam_policy_eks.json
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
    Name = "${local.resource_prefix.value}-eks-vpc"
  }
}

resource aws_subnet "eks_subnet1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.10.10.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.resource_prefix.value}-eks-subnet"
  }
}

resource aws_subnet "eks_subnet2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.10.11.0/24"
  availability_zone       = var.availability_zone2
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.resource_prefix.value}-eks-subnet2"
  }
}

resource aws_eks_cluster "eks_cluster" {
  name     = "${local.resource_prefix.value}-eks"
  role_arn = "${aws_iam_role.iam_for_eks.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.eks_subnet1.id}", "${aws_subnet.eks_subnet2.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.policy_attachment-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.policy_attachment-AmazonEKSServicePolicy",
  ]
}

output "endpoint" {
  value = "${aws_eks_cluster.eks_cluster.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.eks_cluster.certificate_authority.0.data}"
}



data aws_iam_policy_document "iam_policy_eks_nodes" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
        type        = "Service"
        identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource aws_iam_role "iam_for_eks_nodes" {
  name                = "${local.resource_prefix.value}-iam-for-eks-nodes"
  assume_role_policy  = data.aws_iam_policy_document.iam_policy_eks_nodes.json
}

resource "aws_iam_role_policy_attachment" "policy_attachment-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.iam_for_eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "policy_attachment-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.iam_for_eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "policy_attachment-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.iam_for_eks_nodes.name
}


resource aws_eks_node_group "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${local.resource_prefix.value}-eks-nodes"
  node_role_arn   = aws_iam_role.iam_for_eks_nodes.arn
  subnet_ids      = ["${aws_subnet.eks_subnet1.id}", "${aws_subnet.eks_subnet2.id}"]

  instance_types  = ["t3.nano"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.policy_attachment-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.policy_attachment-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.policy_attachment-AmazonEC2ContainerRegistryReadOnly,
  ]
}
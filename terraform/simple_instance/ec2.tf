provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "6e93427dbd5666c3a4ced1fcf1be8b0de028d858"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-09 21:11:41"
    git_last_modified_by = "gms@causalloop.com"
    git_modifiers        = "gms"
    git_org              = "gabe-sky"
    git_repo             = "terragoat"
    yor_trace            = "04d83bd9-9caf-47af-8a7c-f33d075b515a"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "6e93427dbd5666c3a4ced1fcf1be8b0de028d858"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-09 21:11:41"
    git_last_modified_by = "gms@causalloop.com"
    git_modifiers        = "gms"
    git_org              = "gabe-sky"
    git_repo             = "terragoat"
    yor_trace            = "c1019f73-ed7d-4cad-9759-ba4194a3d78b"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

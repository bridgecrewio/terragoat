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
    git_commit           = "3ca878a1745e15004762d8f55b4796c13971dca9"
    git_file             = "terraform/ec2.tf"
    git_last_modified_at = "2021-12-03 21:09:21"
    git_last_modified_by = "mathias.robichon@free.fr"
    git_modifiers        = "mathias.robichon"
    git_org              = "bridgcrewLabMatro"
    git_repo             = "terragoat"
    yor_trace            = "d41dd597-e7fb-4638-aaa5-d2294f6544af"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "3ca878a1745e15004762d8f55b4796c13971dca9"
    git_file             = "terraform/ec2.tf"
    git_last_modified_at = "2021-12-03 21:09:21"
    git_last_modified_by = "mathias.robichon@free.fr"
    git_modifiers        = "mathias.robichon"
    git_org              = "bridgcrewLabMatro"
    git_repo             = "terragoat"
    yor_trace            = "f241e44a-bc2d-40f4-8668-0b408e262398"
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

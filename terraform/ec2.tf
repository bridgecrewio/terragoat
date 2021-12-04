provider "aws" {
  region = "eu-west-3"
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
    git_commit           = "46ace3d70d39f51811411bd666de9eb8f5aaccd6"
    git_file             = "terraform/ec2.tf"
    git_last_modified_at = "2021-12-03 21:27:27"
    git_last_modified_by = "mathias.robichon@free.fr"
    git_modifiers        = "mathias.robichon"
    git_org              = "bridgcrewLabMatro"
    git_repo             = "terragoat"
    yor_trace            = "f79ff165-8932-4249-82c0-3573313e9b10"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "46ace3d70d39f51811411bd666de9eb8f5aaccd6"
    git_file             = "terraform/ec2.tf"
    git_last_modified_at = "2021-12-03 21:27:27"
    git_last_modified_by = "mathias.robichon@free.fr"
    git_modifiers        = "mathias.robichon"
    git_org              = "bridgcrewLabMatro"
    git_repo             = "terragoat"
    yor_trace            = "6d7dd2d2-e9f9-4fe9-b37f-907714670e1b"
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

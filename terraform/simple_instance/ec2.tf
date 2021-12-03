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
    git_commit           = "c757f27fe4fb64e191e9d58827f8f19ec3ff0941"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-03 09:23:44"
    git_last_modified_by = "95222720+dompanw@users.noreply.github.com"
    git_modifiers        = "95222720+dompanw"
    git_org              = "dompanw"
    git_repo             = "terragoat"
    yor_trace            = "da6331df-68b0-411d-ab2c-54df8e3311b3"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "c757f27fe4fb64e191e9d58827f8f19ec3ff0941"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-03 09:23:44"
    git_last_modified_by = "95222720+dompanw@users.noreply.github.com"
    git_modifiers        = "95222720+dompanw"
    git_org              = "dompanw"
    git_repo             = "terragoat"
    yor_trace            = "401a6a66-9c5f-4a0d-8932-a93fed165ec4"
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

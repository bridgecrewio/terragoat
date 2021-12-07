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
    git_commit           = "c6c7ada200a94a4ab346fc229541e2d766360aac"
    git_file             = "terraform/simple_instance/ec2-1.tf"
    git_last_modified_at = "2021-12-07 13:21:15"
    git_last_modified_by = "95222720+dompanw@users.noreply.github.com"
    git_modifiers        = "95222720+dompanw"
    git_org              = "dompanw"
    git_repo             = "terragoat"
    yor_trace            = "9e79a364-a70f-4d7e-bea9-1d974c6199cf"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "c6c7ada200a94a4ab346fc229541e2d766360aac"
    git_file             = "terraform/simple_instance/ec2-1.tf"
    git_last_modified_at = "2021-12-07 13:21:15"
    git_last_modified_by = "95222720+dompanw@users.noreply.github.com"
    git_modifiers        = "95222720+dompanw"
    git_org              = "dompanw"
    git_repo             = "terragoat"
    yor_trace            = "81600f72-d6d1-4d94-a86c-5f92fcf93772"
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

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
    git_commit           = "3b0ab697233687f50a1bf3f8a00c64ca6d94959a"
    git_file             = "ec2.tf"
    git_last_modified_at = "2021-12-06 13:41:28"
    git_last_modified_by = "70904073+darren-kim@users.noreply.github.com"
    git_modifiers        = "70904073+darren-kim"
    git_org              = "darren-kim"
    git_repo             = "terragoat"
    yor_trace            = "22d90a46-e731-4337-ba4b-9848f6d49bd9"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "3b0ab697233687f50a1bf3f8a00c64ca6d94959a"
    git_file             = "ec2.tf"
    git_last_modified_at = "2021-12-06 13:41:28"
    git_last_modified_by = "70904073+darren-kim@users.noreply.github.com"
    git_modifiers        = "70904073+darren-kim"
    git_org              = "darren-kim"
    git_repo             = "terragoat"
    yor_trace            = "3f7edc73-a187-4a02-8f8e-f25d3414bb2f"
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

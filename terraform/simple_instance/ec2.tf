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
    git_commit           = "784b41cdf8a59c379c9ae4f9aa18448f551c2bd9"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2022-02-03 03:26:53"
    git_last_modified_by = "86464908+imjety@users.noreply.github.com"
    git_modifiers        = "86464908+imjety"
    git_org              = "imjety"
    git_repo             = "terragoat"
    yor_trace            = "7f202456-7bb1-452e-b109-f4f2e43c9dd8"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "784b41cdf8a59c379c9ae4f9aa18448f551c2bd9"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2022-02-03 03:26:53"
    git_last_modified_by = "86464908+imjety@users.noreply.github.com"
    git_modifiers        = "86464908+imjety"
    git_org              = "imjety"
    git_repo             = "terragoat"
    yor_trace            = "074d6380-356f-4ede-8de2-4129f01075ec"
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

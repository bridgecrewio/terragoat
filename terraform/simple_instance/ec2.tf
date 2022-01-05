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
    git_commit           = "839c2f2b76f9880f3b7081e4c01171bd1df39340"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2022-01-05 01:55:56"
    git_last_modified_by = "35856167+rbaccus@users.noreply.github.com"
    git_modifiers        = "35856167+rbaccus"
    git_org              = "rbaccus"
    git_repo             = "terragoat"
    yor_trace            = "e484db40-c485-47b7-abe9-8686ddd618f0"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "839c2f2b76f9880f3b7081e4c01171bd1df39340"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2022-01-05 01:55:56"
    git_last_modified_by = "35856167+rbaccus@users.noreply.github.com"
    git_modifiers        = "35856167+rbaccus"
    git_org              = "rbaccus"
    git_repo             = "terragoat"
    yor_trace            = "8ea2b6d2-9304-4a72-868e-6d204c61ac91"
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

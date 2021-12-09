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
    git_commit           = "c5d1570613c012390ee89a3deb5df4ccdb353f28"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-25 12:40:03"
    git_last_modified_by = "42916741+gbrandyb@users.noreply.github.com"
    git_modifiers        = "42916741+gbrandyb"
    git_org              = "gbrandyb"
    git_repo             = "terragoat"
    yor_trace            = "cb592020-b3a0-449a-bd24-f53d2e14cf0d"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_demo_drift_ec2"
    git_commit           = "b5b0d85940c18ddd3bb8c87b1ee7dea5d7cd7b3f"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-09 20:41:42"
    git_last_modified_by = "42916741+gbrandyb@users.noreply.github.com"
    git_modifiers        = "42916741+gbrandyb"
    git_org              = "gbrandyb"
    git_repo             = "terragoat"
    yor_trace            = "921b5bc4-9000-4d98-bb6f-0fa686968c07"
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
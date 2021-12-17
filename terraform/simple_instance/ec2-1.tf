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
    git_commit           = "452c8df1f8a26609e96508324e9dae0f71943d01"
    git_file             = "terraform/simple_instance/ec2-1.tf"
    git_last_modified_at = "2021-12-17 16:16:19"
    git_last_modified_by = "80464597+adelavv@users.noreply.github.com"
    git_modifiers        = "80464597+adelavv"
    git_org              = "adelavv"
    git_repo             = "terragoat"
    yor_trace            = "68a51fff-35f7-4dd1-b554-515662f10743"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "452c8df1f8a26609e96508324e9dae0f71943d01"
    git_file             = "terraform/simple_instance/ec2-1.tf"
    git_last_modified_at = "2021-12-17 16:16:19"
    git_last_modified_by = "80464597+adelavv@users.noreply.github.com"
    git_modifiers        = "80464597+adelavv"
    git_org              = "adelavv"
    git_repo             = "terragoat"
    yor_trace            = "ca6f933c-cc15-420e-b9d0-75520c691610"
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

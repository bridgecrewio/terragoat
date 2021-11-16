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
    git_commit           = "db8e8a5134e07e3869ce1ae9f47180f29ec26af7"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-11-16 19:29:02"
    git_last_modified_by = "87483461+theCaptN21@users.noreply.github.com"
    git_modifiers        = "87483461+theCaptN21"
    git_org              = "theCaptN21"
    git_repo             = "terragoat"
    yor_trace            = "3ea49347-843f-4745-af24-f6e6c92c5db5"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "db8e8a5134e07e3869ce1ae9f47180f29ec26af7"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-11-16 19:29:02"
    git_last_modified_by = "87483461+theCaptN21@users.noreply.github.com"
    git_modifiers        = "87483461+theCaptN21"
    git_org              = "theCaptN21"
    git_repo             = "terragoat"
    yor_trace            = "90447b99-962d-47c5-b26d-f690a505ee6f"
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

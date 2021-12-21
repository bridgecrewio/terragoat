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
    git_commit           = "c32d39a451a39ede65676031b6f0218fccc511f8"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-17 16:00:09"
    git_last_modified_by = "80464597+adelavv@users.noreply.github.com"
    git_modifiers        = "80464597+adelavv"
    git_org              = "adelavv"
    git_repo             = "terragoat"
    yor_trace            = "f253dc85-de8f-4cd9-b476-b58a29a8a29d"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "c32d39a451a39ede65676031b6f0218fccc511f8"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-17 16:00:09"
    git_last_modified_by = "80464597+adelavv@users.noreply.github.com"
    git_modifiers        = "80464597+adelavv"
    git_org              = "adelavv"
    git_repo             = "terragoat"
    yor_trace            = "1b39d594-5f20-4814-97af-afad2703bb51"
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

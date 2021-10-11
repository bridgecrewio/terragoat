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
    git_commit           = "1515a0a75ec6047e23780ad22b544c3b2bb69de0"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-11 14:50:32"
    git_last_modified_by = "murali@banyandata.com"
    git_modifiers        = "murali"
    git_org              = "bds1959"
    git_repo             = "terragoat"
    yor_trace            = "ece8293a-e8a1-4a0c-94ba-29d27a06f2ca"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "1515a0a75ec6047e23780ad22b544c3b2bb69de0"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-11 14:50:32"
    git_last_modified_by = "murali@banyandata.com"
    git_modifiers        = "murali"
    git_org              = "bds1959"
    git_repo             = "terragoat"
    yor_trace            = "9f97a140-de7b-4390-939a-ef3b3e17ccb0"
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

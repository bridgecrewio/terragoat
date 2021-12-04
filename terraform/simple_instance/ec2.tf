provider "aws" {
  region = "eu-west-3"
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
    git_commit           = "64fbb597901fe1a7d70d6f9ac0399d3b72645a5f"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-04 14:41:13"
    git_last_modified_by = "mathias.robichon@free.fr"
    git_modifiers        = "mathias.robichon"
    git_org              = "bridgcrewLabMatro"
    git_repo             = "terragoat"
    yor_trace            = "8868e930-2c9e-49db-aa5b-8a1748509fb7"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "64fbb597901fe1a7d70d6f9ac0399d3b72645a5f"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-04 14:41:13"
    git_last_modified_by = "mathias.robichon@free.fr"
    git_modifiers        = "mathias.robichon"
    git_org              = "bridgcrewLabMatro"
    git_repo             = "terragoat"
    yor_trace            = "2e5e8629-8d2f-4b22-943e-a7a5f9de3b59"
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

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
    git_commit           = "e02adad793909429077cc36b42835d6db7b23b60"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-02 17:41:32"
    git_last_modified_by = "67233434+ivan-tresoldi@users.noreply.github.com"
    git_modifiers        = "67233434+ivan-tresoldi"
    git_org              = "ivan-tresoldi"
    git_repo             = "terragoat"
    yor_trace            = "983b88c3-8e5a-4c82-801b-09561038c234"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "e02adad793909429077cc36b42835d6db7b23b60"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-02 17:41:32"
    git_last_modified_by = "67233434+ivan-tresoldi@users.noreply.github.com"
    git_modifiers        = "67233434+ivan-tresoldi"
    git_org              = "ivan-tresoldi"
    git_repo             = "terragoat"
    yor_trace            = "2af6f1f8-c62f-4620-b411-10d6dbe46f78"
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

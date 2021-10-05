provider "aws" {
  region  = "eu-central-1"
  profile = "Ivan-SSO"
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
    git_commit           = "772990ca96538c8a059af669073b3dbf048c796b"
    git_file             = "terraform/terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-05 10:04:16"
    git_last_modified_by = "67233434+ivan-tresoldi@users.noreply.github.com"
    git_modifiers        = "67233434+ivan-tresoldi"
    git_org              = "ivan-tresoldi"
    git_repo             = "terragoat"
    yor_trace            = "fdce325c-3ec3-4679-ab19-e42c196804cf"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "772990ca96538c8a059af669073b3dbf048c796b"
    git_file             = "terraform/terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-05 10:04:16"
    git_last_modified_by = "67233434+ivan-tresoldi@users.noreply.github.com"
    git_modifiers        = "67233434+ivan-tresoldi"
    git_org              = "ivan-tresoldi"
    git_repo             = "terragoat"
    yor_trace            = "7819b3d4-d0b5-4506-839d-305efdc64ef7"
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

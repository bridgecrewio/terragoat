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
    git_commit           = "932dc9c44d97c73679c677873e6618514ab688ad"
    git_file             = "terraform/simple_instance/new_ec2.tf"
    git_last_modified_at = "2021-10-04 16:34:20"
    git_last_modified_by = "67233434+ivan-tresoldi@users.noreply.github.com"
    git_modifiers        = "67233434+ivan-tresoldi"
    git_org              = "ivan-tresoldi"
    git_repo             = "terragoat"
    yor_trace            = "504c36ee-9609-4f5f-bc36-927a644709d1"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "932dc9c44d97c73679c677873e6618514ab688ad"
    git_file             = "terraform/simple_instance/new_ec2.tf"
    git_last_modified_at = "2021-10-04 16:34:20"
    git_last_modified_by = "67233434+ivan-tresoldi@users.noreply.github.com"
    git_modifiers        = "67233434+ivan-tresoldi"
    git_org              = "ivan-tresoldi"
    git_repo             = "terragoat"
    yor_trace            = "65bdf00b-e01f-482b-a1f8-3f66ec662b88"
  }
  ebs_optimized = true
  monitoring = true
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

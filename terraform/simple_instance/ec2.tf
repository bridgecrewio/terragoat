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
    git_commit           = "cb366ead661c8dc65aa5e97b687829a6a7dab7ea"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-22 02:21:48"
    git_last_modified_by = "44179932+lcastrose@users.noreply.github.com"
    git_modifiers        = "44179932+lcastrose"
    git_org              = "lcastrose"
    git_repo             = "terragoat"
    yor_trace            = "06c9d400-0e01-4425-868e-d1752957eb0f"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "cb366ead661c8dc65aa5e97b687829a6a7dab7ea"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-22 02:21:48"
    git_last_modified_by = "44179932+lcastrose@users.noreply.github.com"
    git_modifiers        = "44179932+lcastrose"
    git_org              = "lcastrose"
    git_repo             = "terragoat"
    yor_trace            = "a83ed2aa-ecf3-4e37-af28-8402e7316db9"
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

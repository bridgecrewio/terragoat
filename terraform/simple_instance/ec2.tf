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
    git_commit           = "eb845306cc9b09f355699a4dc175041a63a1af13"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-11 17:46:26"
    git_last_modified_by = "94945518+jabe11@users.noreply.github.com"
    git_modifiers        = "94945518+jabe11"
    git_org              = "jabe11"
    git_repo             = "terragoat"
    yor_trace            = "5a6e49df-7694-4fe0-97de-3b9eb234eda9"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "eb845306cc9b09f355699a4dc175041a63a1af13"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-12-11 17:46:26"
    git_last_modified_by = "94945518+jabe11@users.noreply.github.com"
    git_modifiers        = "94945518+jabe11"
    git_org              = "jabe11"
    git_repo             = "terragoat"
    yor_trace            = "4f6f3be5-1aa2-4ff6-a8a1-36ba16d70859"
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

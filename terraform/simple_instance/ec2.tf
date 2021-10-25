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
    git_commit           = "c5d1570613c012390ee89a3deb5df4ccdb353f28"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-25 12:40:03"
    git_last_modified_by = "42916741+gbrandyb@users.noreply.github.com"
    git_modifiers        = "42916741+gbrandyb"
    git_org              = "gbrandyb"
    git_repo             = "terragoat"
    yor_trace            = "7e6e37fc-8cbe-4744-aef2-c545e234439e"
  }
  vpc_id = "vpc-4d481735"
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "c5d1570613c012390ee89a3deb5df4ccdb353f28"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-25 12:40:03"
    git_last_modified_by = "42916741+gbrandyb@users.noreply.github.com"
    git_modifiers        = "42916741+gbrandyb"
    git_org              = "gbrandyb"
    git_repo             = "terragoat"
    yor_trace            = "e39c7464-1bd5-4622-9c22-b29eebdb73c7"
  }
  associate_public_ip_address = true
  availability_zone           = "us-west-2b"
  cpu_core_count              = "1"
  cpu_threads_per_core        = "1"
  credit_specification        = { "cpu_credits" : "standard" }
  disable_api_termination     = false
  ebs_optimized               = false
  get_password_data           = false
  hibernation                 = false
  ipv6_address_count          = "0"
  metadata_options            = { "http_endpoint" : "enabled", "http_put_response_hop_limit" : "1", "http_tokens" : "optional" }
  monitoring                  = false
  private_ip                  = "172.31.25.58"
  root_block_device           = { "delete_on_termination" : true, "encrypted" : false, "iops" : "100", "volume_size" : "8", "volume_type" : "gp2" }
  source_dest_check           = true
  subnet_id                   = "subnet-daf25aa2"
  tenancy                     = "default"
  vpc_security_group_ids      = ["sg-01566303a20197dcd"]
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

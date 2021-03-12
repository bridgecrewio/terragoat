provider "aws" {
  region = "us-east-1"
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
}

resource "aws_instance" "web_server_instance" {
  ami = "ami-03d315ad33b9d49c4"
  instance_type = "t2.micro"
  security_groups = [ "${aws_security_group.ssh_traffic.name}" ]
}

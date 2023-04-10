terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name      = "tf_test"
    zs-key    = "new1"
    yor_trace = "c80c8d44-0cbe-4329-aff6-65c450917cea"
  }
}

resource "aws_subnet" "tf_test_subnet" {
  vpc_id     = aws_vpc.default.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name      = "zs_test_subnet"
    zs-key    = "new1"
    yor_trace = "485fe745-1db1-4509-9fcc-096fb4ac2d57"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name      = "tf_test_ig"
    zs-key    = "new1"
    yor_trace = "45a19f77-ac28-468e-a2c0-06a70a183d13"
  }
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name      = "aws_route_table"
    zs-key    = "new1"
    yor_trace = "06c2fbb5-3bd7-4fa1-92f8-843b8407c0a7"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.tf_test_subnet.id
  route_table_id = aws_route_table.r.id
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "instance_sg"
  description = "Used in the terraform"
  vpc_id      = aws_vpc.default.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    zs-key    = "new1"
    yor_trace = "bbaa0458-b652-412d-a5fd-49ec40629338"
  }
}

# Our elb security group to access
# the ELB over HTTP
resource "aws_security_group" "elb" {
  name        = "elb_sg"
  description = "Used in the terraform"

  vpc_id = aws_vpc.default.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ensure the VPC has an Internet gateway or this step will fail
  depends_on = [aws_internet_gateway.gw]
  tags = {
    zs-key    = "new1"
    yor_trace = "a162256c-cdc9-4843-9d89-905f2e4a17d5"
  }
}

resource "aws_elb" "web" {
  name = "example-elb"

  # The same availability zone as our instance
  subnets = [aws_subnet.tf_test_subnet.id]

  security_groups = [aws_security_group.elb.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  # The instance is registered automatically

  instances                   = [aws_instance.web.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    zs-key    = "new1"
    yor_trace = "c7c53356-86cc-483a-96d7-3ff21d2d8329"
  }
}

resource "aws_lb_cookie_stickiness_policy" "default" {
  name                     = "lbpolicy"
  load_balancer            = aws_elb.web.id
  lb_port                  = 80
  cookie_expiration_period = 600
}

resource "aws_instance" "web" {
  instance_type = "t2.micro"

  # Lookup the correct AMI based on the region
  # we specified
  ami = var.aws_amis[var.aws_region]

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = var.key_name

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = [aws_security_group.default.id]
  subnet_id              = aws_subnet.tf_test_subnet.id
  user_data              = file("userdata.sh")

  #Instance tags

  tags = {
    Name      = "elb-example"
    zs-key    = "new1"
    yor_trace = "fecb1e83-d350-4e93-8622-739cc1e06ec5"
  }
}

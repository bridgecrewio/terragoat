# Create a new load balancer
resource "aws_elb" "weblb" {
  # checkov:skip=CKV_AWS_127: Testing skip comment feature
  # checkov:skip=CKV_AWS_92: Testing skip comment feature
  name = "weblb-terraform-elb"

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  subnets                     = [aws_subnet.web_subnet.id]
  security_groups             = [aws_security_group.web-node.id]
  instances                   = [aws_instance.web_host.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = merge({
    Name = "foobar-terraform-elb"
    }, {
    git_commit           = "95914a45af49b1266f4f6043be288f72e9f905e1"
    git_file             = "terraform/aws/elb.tf"
    git_last_modified_at = "2021-12-20 22:30:39"
    git_last_modified_by = "jbrooks@paloaltontworks.com"
    git_modifiers        = "jbrooks/nimrodkor"
    git_org              = "panwtraining"
    git_repo             = "terragoat"
    yor_trace            = "b4a83ce9-9a45-43b4-b6d9-1783c282f702"
  })
}
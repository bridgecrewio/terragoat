module "sg1" {
  source = "./terraform/aws/modules/security_group"

  port = 22
  cidrs = ["0.0.0.0/0"]

}

module "sg2" {
  source = "./modules/security_group"

  port = 22
  cidrs = ["0.0.0.0/0"]

}

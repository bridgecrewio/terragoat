output "instance_id" {
  value       = module.ec2_bastion.instance_id
  description = "Instance ID"
}

output "ssh_user" {
  value       = var.ssh_user
  description = "SSH user"
}

output "security_group_id" {
  value       = module.ec2_bastion.security_group_id
  description = "Security group ID"
}

output "role" {
  value       = module.ec2_bastion.role
  description = "Name of AWS IAM Role associated with the instance"
}

output "public_ip" {
  value       = module.ec2_bastion.public_ip
  description = "Public IP of the instance (or EIP)"
}

output "private_ip" {
  value       = module.ec2_bastion.private_ip
  description = "Private IP of the instance"
}

output "public_subnet_cidrs" {
  value = module.subnets.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  value = module.subnets.private_subnet_cidrs
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}

output "key_name" {
  value = module.aws_key_pair.key_name
}

output "public_key" {
  value = module.aws_key_pair.public_key
}

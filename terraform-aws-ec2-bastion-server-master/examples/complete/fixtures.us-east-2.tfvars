region = "us-east-2"

availability_zones = ["us-east-2a", "us-east-2b"]

namespace = "eg"

stage = "test"

name = "ec2-bastion"

ami = "ami-01237fce26136c8cc"

instance_type = "t3a.nano"

ssh_user = "ubuntu"

ssh_key_path = "./secrets"

generate_ssh_key = true

user_data = [
  "apt-get install -y postgresql-client-common"
]

security_groups = []

ingress_security_groups = []

root_block_device_encrypted = true

metadata_http_tokens_required = true

associate_public_ip_address = true
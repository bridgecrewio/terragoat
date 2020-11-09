<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |
| aws | ~> 2.55 |
| null | ~> 2.1 |
| template | ~> 2.1 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.55 |
| template | ~> 2.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_cidr\_blocks | A list of CIDR blocks allowed to connect | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| ami | AMI to use | `string` | `"ami-efd0428f"` | no |
| associate\_public\_ip\_address | Whether to associate a public IP to the instance. | `bool` | `true` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| enabled | When disabled, module will not create any resources | `bool` | `true` | no |
| ingress\_security\_groups | AWS security group IDs allowed ingress to instance | `list(string)` | `[]` | no |
| instance\_type | Elastic cache instance type | `string` | `"t2.micro"` | no |
| key\_name | Key name | `string` | `""` | no |
| metadata\_http\_endpoint\_enabled | Whether the metadata service is available | `bool` | `true` | no |
| metadata\_http\_put\_response\_hop\_limit | The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests. | `number` | `1` | no |
| metadata\_http\_tokens\_required | Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2. | `bool` | `false` | no |
| name | Name  (e.g. `app` or `bastion`) | `string` | n/a | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | `string` | n/a | yes |
| root\_block\_device\_encrypted | Whether to encrypt the root block device | `bool` | `false` | no |
| root\_block\_device\_volume\_size | The volume size (in GiB) to provision for the root block device. It cannot be smaller than the AMI it refers to. | `number` | `8` | no |
| security\_groups | AWS security group IDs associated with instance | `list(string)` | `[]` | no |
| ssh\_user | Default SSH user for this AMI. e.g. `ec2user` for Amazon Linux and `ubuntu` for Ubuntu systems | `string` | n/a | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | `string` | n/a | yes |
| subnets | AWS subnet IDs | `list(string)` | n/a | yes |
| tags | Additional tags (e.g. map('BusinessUnit`,`XYZ`)` | `map(string)` | `{}` | no |
| user\_data | User data content | `list(string)` | `[]` | no |
| vpc\_id | VPC ID | `string` | n/a | yes |
| zone\_id | Route53 DNS Zone ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| hostname | DNS hostname |
| instance\_id | Instance ID |
| private\_ip | Private IP of the instance |
| public\_ip | Public IP of the instance (or EIP) |
| role | Name of AWS IAM Role associated with the instance |
| security\_group\_id | Security group ID |
| ssh\_user | SSH user |

<!-- markdownlint-restore -->

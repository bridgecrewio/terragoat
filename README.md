# TerraGoat - Vulnerable Terraform Infrastructure 
[![Maintained by Bridgecrew.io](https://img.shields.io/badge/maintained%20by-bridgecrew.io-blueviolet)](https://bridge.dev/2WBms5Q)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.12.0-blue.svg)

TerraGoat is Bridgecrew's "Vulnerable by Design" Terraform repository.
[![Terragoat](terragoat-logo.png)](#)

TerraGoat is Bridgecrew's "Vulnerable by Design" Terraform repository.
TerraGoat is a learning and training project that demonstrates how common configuration errors can find their way into production cloud environments.


## Table of Contents

* [Introduction](#introduction)
* [Getting Started](#getting-started)
* [Contributing](#contributing)
* [Support](#support)

## Introduction

TerraGoat was built to enable DevSecOps design and implement a sustainable misconfiguration prevention strategy. It can be used to test a policy-as-code framework like [Checkov](https://github.com/bridgecrewio/checkov/), inline-linters, pre-commit hooks or other code scanning methods.

TerraGoat follows the tradition of existing *Goat projects that provide a baseline training ground to practice implementing secure development best practices for cloud infrastructure.

## Important notes
* **Where to get help:** the [Bridgecrew Community Slack](https://codified-security.herokuapp.com/)

Before you proceed please take a not of these warning:
> :warning: TerraGoat creates intentionally vulnerable AWS resources into your account. **DO NOT deploy TerraGoat in a production environment or alongside any sensitive AWS resources.**

## Requirements
* Terraform 0.12 
* aws cli

To prevent vulnerable infrastructure from arriving to production 
see: [checkov](https://github.com/bridgecrewio/checkov/), the open source static analysis tool for infrastructure as code. 

## Getting started
### Installation
You can deploy multiple TerraGoat stacks in a single AWS account using the parameters `TF_VAR_environment` and `TF_VAR_environment`.
 
#### Create an S3 bucket backend to keep Terraform state
```bash
export TERRAGOAT_STATE_BUCKET="mydevsecops-bucket"
export TF_VAR_company_name=acme
export TF_VAR_environment=mydevsecops
export TF_VAR_region="us-west-2"

aws s3api create-bucket --bucket $TERRAGOAT_STATE_BUCKET \
    --region $TF_VAR_region --create-bucket-configuration LocationConstraint=$TF_VAR_region

# Enable versioning    
aws s3api put-bucket-versioning --bucket $TERRAGOAT_STATE_BUCKET --versioning-configuration Status=Enabled

# Enable encryption
aws s3api put-bucket-encryption --bucket $TERRAGOAT_STATE_BUCKET --server-side-encryption-configuration '{
  "Rules": [
    {
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "aws:kms"
      }
    }
  ]
}'
```

#### Apply TerraGoat
```bash
cd terraform/
terraform init \
-backend-config="bucket=$TERRAGOAT_STATE_BUCKET" \
-backend-config="key=$TF_VAR_company_name-$TF_VAR_environment.tfstate" \
-backend-config="region=$TF_VAR_region"

terraform apply
```

#### Remove TerraGoat
```bash
terraform destroy
```

#### Creating multiple TerraGoat stacks 
```bash

cd terraform/
export TERRAGOAT_ENV=$TF_VAR_environment
export TERRAGOAT_STACKS_NUM=5
for i in $(seq 1 $TERRAGOAT_STACKS_NUM)
do
    export TF_VAR_environment=$TERRAGOAT_ENV$i   
    terraform init \
    -backend-config="bucket=$TERRAGOAT_STATE_BUCKET" \
    -backend-config="key=$TF_VAR_company_name-$TF_VAR_environment.tfstate" \
    -backend-config="region=$TF_VAR_region" 
    
    terraform apply -auto-approve
done
```

#### Deleting multiple TerraGoat stacks 
```bash

cd terraform/
export TF_VAR_environment = $TERRAGOAT_ENV
for i in $(seq 1 $TERRAGOAT_STACKS_NUM)
do
    export TF_VAR_environment=$TERRAGOAT_ENV$i   
    terraform init \
    -backend-config="bucket=$TERRAGOAT_STATE_BUCKET" \
    -backend-config="key=$TF_VAR_company_name-$TF_VAR_environment.tfstate" \
    -backend-config="region=$TF_VAR_region" 
    
    terraform destroy -auto-approve
done
```


## Bridgecrew's IaC heard of goats:
* [CfnGoat](https://github.com/bridgecrewio/cfngoat) - Vulnerable by design Cloudformation template
* [TerraGoat](https://github.com/bridgecrewio/terragoat) - Vulnerable by design Terraform stack

## Contributing

Contribution is welcomed!

We would love to hear about more ideas on how to find vulnerable infrastructure-as-code design patterns.

## Support

[Bridgecrew](https://bridge.dev/2WBms5Q) builds and maintains TerraGoat to encourage the adoption of policy-as-code.

If you need direct support you can contact us at [info@bridgecrew.io](mailto:info@bridgecrew.io).

# Existing vulnerabilities (Auto-Generated)
|    | check_id   | file          | resource                                      | check_name                                                                                                                                                                                               |
|----|------------|---------------|-----------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  0 | CKV_AWS_41 | /providers.tf | aws                                           | Ensure no hard coded AWS access key and and secret key exists in provider                                                                                                                                |
|  1 | CKV_AWS_5  | /es.tf        | aws_elasticsearch_domain.monitoring-framework | Ensure all data stored in the Elasticsearch is securely encrypted at rest                                                                                                                                |
|  2 | CKV_AWS_46 | /ec2.tf       | aws_instance.web_host                         | Ensure no hard coded AWS access key and and secret key exists in EC2 user data                                                                                                                           |
|  3 | CKV_AWS_8  | /ec2.tf       | aws_instance.web_host                         | Ensure all data stored in the Launch configuration EBS is securely encrypted                                                                                                                             |
|  4 | CKV_AWS_3  | /ec2.tf       | aws_ebs_volume.web_host_storage               | Ensure all data stored in the EBS is securely encrypted                                                                                                                                                  |
|  5 | CKV_AWS_4  | /ec2.tf       | aws_ebs_snapshot.example_snapshot             | Ensure all data stored in the EBS Snapshot is securely encrypted                                                                                                                                         |
|  6 | CKV_AWS_24 | /ec2.tf       | aws_security_group.web-node                   | Ensure no security groups allow ingress from 0.0.0.0:0 to port 22                                                                                                                                        |
|  7 | CKV_AWS_21 | /ec2.tf       | aws_s3_bucket.flowbucket                      | Ensure all data stored in the S3 bucket have versioning enabled                                                                                                                                          |
|  8 | CKV_AWS_18 | /ec2.tf       | aws_s3_bucket.flowbucket                      | Ensure the S3 bucket has access logging enabled                                                                                                                                                          |
|  9 | CKV_AWS_52 | /ec2.tf       | aws_s3_bucket.flowbucket                      | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 10 | CKV_AWS_19 | /ec2.tf       | aws_s3_bucket.flowbucket                      | Ensure all data stored in the S3 bucket is securely encrypted at rest                                                                                                                                    |
| 11 | CKV_AWS_40 | /iam.tf       | aws_iam_user_policy.userpolicy                | Ensure IAM policies are attached only to groups or roles (Reducing access management complexity may in-turn reduce opportunity for a principal to inadvertently receive or retain excessive privileges.) |
| 12 | CKV_AWS_51 | /ecr.tf       | aws_ecr_repository.repository                 | Ensure ECR Image Tags are immutable                                                                                                                                                                      |
| 13 | CKV_AWS_33 | /ecr.tf       | aws_ecr_repository.repository                 | Ensure ECR image scanning on push is enabled                                                                                                                                                             |
| 14 | CKV_AWS_21 | /s3.tf        | aws_s3_bucket.data                            | Ensure all data stored in the S3 bucket have versioning enabled                                                                                                                                          |
| 15 | CKV_AWS_18 | /s3.tf        | aws_s3_bucket.data                            | Ensure the S3 bucket has access logging enabled                                                                                                                                                          |
| 16 | CKV_AWS_52 | /s3.tf        | aws_s3_bucket.data                            | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 17 | CKV_AWS_20 | /s3.tf        | aws_s3_bucket.data                            | S3 Bucket has an ACL defined which allows public READ access.                                                                                                                                            |
| 18 | CKV_AWS_19 | /s3.tf        | aws_s3_bucket.data                            | Ensure all data stored in the S3 bucket is securely encrypted at rest                                                                                                                                    |
| 19 | CKV_AWS_21 | /s3.tf        | aws_s3_bucket.financials                      | Ensure all data stored in the S3 bucket have versioning enabled                                                                                                                                          |
| 20 | CKV_AWS_18 | /s3.tf        | aws_s3_bucket.financials                      | Ensure the S3 bucket has access logging enabled                                                                                                                                                          |
| 21 | CKV_AWS_52 | /s3.tf        | aws_s3_bucket.financials                      | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 22 | CKV_AWS_19 | /s3.tf        | aws_s3_bucket.financials                      | Ensure all data stored in the S3 bucket is securely encrypted at rest                                                                                                                                    |
| 23 | CKV_AWS_18 | /s3.tf        | aws_s3_bucket.operations                      | Ensure the S3 bucket has access logging enabled                                                                                                                                                          |
| 24 | CKV_AWS_52 | /s3.tf        | aws_s3_bucket.operations                      | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 25 | CKV_AWS_19 | /s3.tf        | aws_s3_bucket.operations                      | Ensure all data stored in the S3 bucket is securely encrypted at rest                                                                                                                                    |
| 26 | CKV_AWS_52 | /s3.tf        | aws_s3_bucket.data_science                    | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 27 | CKV_AWS_19 | /s3.tf        | aws_s3_bucket.data_science                    | Ensure all data stored in the S3 bucket is securely encrypted at rest                                                                                                                                    |
| 28 | CKV_AWS_18 | /s3.tf        | aws_s3_bucket.logs                            | Ensure the S3 bucket has access logging enabled                                                                                                                                                          |
| 29 | CKV_AWS_52 | /s3.tf        | aws_s3_bucket.logs                            | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 30 | CKV_AWS_16 | /db-app.tf    | aws_db_instance.default                       | Ensure all data stored in the RDS is securely encrypted at rest                                                                                                                                          |
| 31 | CKV_AWS_17 | /db-app.tf    | aws_db_instance.default                       | Ensure all data stored in the RDS bucket is not public accessible                                                                                                                                        |
| 32 | CKV_AWS_23 | /db-app.tf    | aws_security_group.default                    | Ensure every security groups rule has a description                                                                                                                                                      |
| 33 | CKV_AWS_23 | /db-app.tf    | aws_security_group_rule.ingress               | Ensure every security groups rule has a description                                                                                                                                                      |
| 34 | CKV_AWS_23 | /db-app.tf    | aws_security_group_rule.egress                | Ensure every security groups rule has a description                                                                                                                                                      |
| 35 | CKV_AWS_8  | /db-app.tf    | aws_instance.db_app                           | Ensure all data stored in the Launch configuration EBS is securely encrypted                                                                                                                             |
| 36 | CKV_AWS_50 | /lambda.tf    | aws_lambda_function.analysis_lambda           | X-ray tracing is enabled for Lambda                                                                                                                                                                      |
| 37 | CKV_AWS_45 | /lambda.tf    | aws_lambda_function.analysis_lambda           | Ensure no hard coded AWS access key and and secret key exists in lambda environment                                                                                                                      |
| 38 | CKV_AWS_7  | /kms.tf       | aws_kms_key.logs_key                          | Ensure rotation for customer created CMKs is enabled                                                                                                                                                     |
| 39 | CKV_AWS_37 | /eks.tf       | aws_eks_cluster.eks_cluster                   | Ensure Amazon EKS control plane logging enabled for all log types                                                                                                                                        |
| 40 | CKV_AWS_38 | /eks.tf       | aws_eks_cluster.eks_cluster                   | Ensure Amazon EKS public endpoint not accessible to 0.0.0.0/0                                                                                                                                            |
| 41 | CKV_AWS_39 | /eks.tf       | aws_eks_cluster.eks_cluster                   | Ensure Amazon EKS public endpoint disabled                                                                                                                                                               |
| 42 | CKV_AWS_58 | /eks.tf       | aws_eks_cluster.eks_cluster                   | Ensure EKS Cluster has Secrets Encryption Enabled                                                                                                                                                        |


---



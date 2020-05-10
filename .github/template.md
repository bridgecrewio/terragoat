# TerraGoat - Vulnerable Terraform Infrastructure 
[![Maintained by Bridgecrew.io](https://img.shields.io/badge/maintained%20by-bridgecrew.io-blueviolet)](https://bridge.dev/2WBms5Q)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.12.0-blue.svg)

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
export TF_VAR_region="us-east-1"

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

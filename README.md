# TerraGoat - Vulnerable Terraform infrastructure 

[![Maintained by Bridgecrew.io](https://img.shields.io/badge/maintained%20by-bridgecrew.io-blueviolet)](https://bridgecrew.io/?utm_source=github&utm_medium=organic_oss&utm_campaign=checkov)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.12.0-blue.svg)

TerraGoat is a learning and training project that demonstrates how common configuration errors can find their way into production cloud environments. 

## Table of Contents

* [Introduction](#introduction)
* [Getting Started](#getting-started)
* [Contributing](#contributing)
* [Support](#support)

## Introduction

TerraGoat was built to enable DevSecOps design and implement a sustainable misconfiguration prevention strategy. It can be used to test a policy-as-code framework like [Checkov](https://github.com/bridgecrewio/checkov/), inline-linters, pre-commit hooks or other code scanning methods.

TerraGoat follows the tradition of existing *Goat projects that provide a baseline training ground to practice implementing secure development best practices for cloud infrastructure.

## Getting started

### Installation

You can deploy multiple terragoat stacks in a single AWS account using the parameters `TF_VAR_environment` and `TF_VAR_environment`.

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

#### Apply terragoat

```bash
cd terraform/
terraform init \
-backend-config="bucket=$TERRAGOAT_STATE_BUCKET" \
-backend-config="key=$TF_VAR_company_name-$TF_VAR_environment.tfstate" \
-backend-config="region=$TF_VAR_region"

terraform apply
```

#### Remove terragoat

```bash
terraform destroy
```

#### Creating multiple terragoat stacks 

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

#### Deleting multiple terragoat stacks 

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

## Contributing

Contribution is welcomed!

We would love to hear about more ideas on how to find vulnerable infrastructure-as-code design patterns.

## Support

[Bridgecrew](https://bridgecrew.io/) builds and maintains TerraGoat to encourage the adoption of policy-as-code.

Start with our [Documentation](https://bridgecrewio.github.io/airiam/) for quick tutorials and examples.

If you need direct support you can contact us at [info@bridgecrew.io](mailto:info@bridgecrew.io).

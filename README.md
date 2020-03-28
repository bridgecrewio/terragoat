# Terragoat
Bridgecrew solution to create vulnerable infrastructure

## Getting started
### Installation
You can deploy multiple terragoat stacks in a single AWS account using the parameters `TF_VAR_environment` and `TF_VAR_environment`.
 
#### Create S3 bucket backend to keep Terraform state
```bash
export TERRAGOAT_STATE_BUCKET=PUT_BUCKET_NAME_HERE
export TF_VAR_company_name="acme"
export TF_VAR_environment="dev"
export TF_VAR_region="us-west-2"

aws s3api create-bucket --bucket $TERRAGOAT_STATE_BUCKET \
    --region TF_VAR_region

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
for i in {1..$TERRAGOAT_STACKS_NUM}
do
    export $TF_VAR_environment = $TERRAGOAT_ENV$i    
    terraform init \
    -backend-config="bucket=$TERRAGOAT_STATE_BUCKET" \
    -backend-config="key=$TF_VAR_company_name-$TF_VAR_environment.tfstate" \
    -backend-config="region=$TF_VAR_region" \
    
    terraform apply -auto-approve
done
```

#### Deleting multiple terragoat stacks 
```bash

cd terraform/
export TF_VAR_environment = $TERRAGOAT_ENV
for i in {1..$TERRAGOAT_STACKS_NUM}
do
    export $TF_VAR_environment = $TERRAGOAT_ENV$i    
    terraform init \
    -backend-config="bucket=$TERRAGOAT_STATE_BUCKET" \
    -backend-config="key=$TF_VAR_company_name-$TF_VAR_environment.tfstate" \
    -backend-config="region=$TF_VAR_region" \
    
    terraform destroy -auto-approve
done
```
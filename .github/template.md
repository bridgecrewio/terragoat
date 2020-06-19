# TerraGoat - Vulnerable Terraform Infrastructure

[![Maintained by Bridgecrew.io](https://img.shields.io/badge/maintained%20by-bridgecrew.io-blueviolet)](https://bridge.dev/2WBms5Q)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.12.0-blue.svg)

TerraGoat is Bridgecrew's "Vulnerable by Design" Terraform repository.
![Terragoat](terragoat-logo.png)

TerraGoat is Bridgecrew's "Vulnerable by Design" Terraform repository.
TerraGoat is a learning and training project that demonstrates how common configuration errors can find their way into production cloud environments.

## Table of Contents

* [Introduction](#introduction)
* [Getting Started](#getting-started)
  * [AWS](#aws-setup)
  * [Azure](#azure-setup)
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
* azure cli

To prevent vulnerable infrastructure from arriving to production see: [checkov](https://github.com/bridgecrewio/checkov/), the open source static analysis tool for infrastructure as code.

## Getting started

### AWS Setup

#### Installation (AWS)

You can deploy multiple TerraGoat stacks in a single AWS account using the parameter `TF_VAR_environment`.

#### Create an S3 Bucket backend to keep Terraform state

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

#### Apply TerraGoat (AWS)

```bash
cd terraform/aws/
terraform init \
-backend-config="bucket=$TERRAGOAT_STATE_BUCKET" \
-backend-config="key=$TF_VAR_company_name-$TF_VAR_environment.tfstate" \
-backend-config="region=$TF_VAR_region"

terraform apply
```

#### Remove TerraGoat (AWS)

```bash
terraform destroy
```

#### Creating multiple TerraGoat AWS stacks

```bash
cd terraform/aws/
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

#### Deleting multiple TerraGoat stacks (AWS)

```bash
cd terraform/aws/
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

### Azure Setup

#### Installation (Azure)

You can deploy multiple TerraGoat stacks in a single Azure subscription using the parameter `TF_VAR_environment`.

#### Create an Azure Storage Account backend to keep Terraform state

```bash
export TERRAGOAT_RESOURCE_GROUP="TerraGoatRG"
export TERRAGOAT_STATE_STORAGE_ACCOUNT="mydevsecopssa"
export TERRAGOAT_STATE_CONTAINER="mydevsecops"
export TF_VAR_environment="dev"
export TF_VAR_region="westus"

# Create resource group
az group create --location $TF_VAR_region --name $TERRAGOAT_RESOURCE_GROUP

# Create storage account
az storage account create --name $TERRAGOAT_STATE_STORAGE_ACCOUNT --resource-group $TERRAGOAT_RESOURCE_GROUP --location $TF_VAR_region --sku Standard_LRS --kind StorageV2 --https-only true --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $TERRAGOAT_RESOURCE_GROUP --account-name $TERRAGOAT_STATE_STORAGE_ACCOUNT --query [0].value -o tsv)

# Create blob container
az storage container create --name $TERRAGOAT_STATE_CONTAINER --account-name $TERRAGOAT_STATE_STORAGE_ACCOUNT --account-key $ACCOUNT_KEY
```

#### Apply TerraGoat (Azure)

```bash
cd terraform/azure/
terraform init -reconfigure -backend-config="resource_group_name=$TERRAGOAT_RESOURCE_GROUP" \
    -backend-config "storage_account_name=$TERRAGOAT_STATE_STORAGE_ACCOUNT" \
    -backend-config="container_name=$TERRAGOAT_STATE_CONTAINER" \
    -backend-config "key=$TF_VAR_environment.terraform.tfstate"

terraform apply
```

#### Remove TerraGoat (Azure)

```shell script
terraform destroy
```

## Bridgecrew's IaC herd of goats

* [CfnGoat](https://github.com/bridgecrewio/cfngoat) - Vulnerable by design Cloudformation template
* [TerraGoat](https://github.com/bridgecrewio/terragoat) - Vulnerable by design Terraform stack

## Contributing

Contribution is welcomed!

We would love to hear about more ideas on how to find vulnerable infrastructure-as-code design patterns.

## Support

[Bridgecrew](https://bridge.dev/2WBms5Q) builds and maintains TerraGoat to encourage the adoption of policy-as-code.

If you need direct support you can contact us at [info@bridgecrew.io](mailto:info@bridgecrew.io).

## Existing vulnerabilities (Auto-Generated)

|    | check_id     | file                      | resource                                             | check_name                                                                                                                                                                                               |
|----|--------------|---------------------------|------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  0 | CKV_AZURE_2  | /azure/storage.tf         | azurerm_managed_disk.example                         | Ensure Azure managed disk have encryption enabled                                                                                                                                                        |
|  1 | CKV_AZURE_3  | /azure/storage.tf         | azurerm_storage_account.example                      | Ensure that 'Secure transfer required' is set to 'Enabled'                                                                                                                                               |
|  2 | CKV_AZURE_35 | /azure/storage.tf         | azurerm_storage_account.example                      | Ensure default network access rule for Storage Accounts is set to deny                                                                                                                                   |
|  3 | CKV_AZURE_33 | /azure/storage.tf         | azurerm_storage_account.example                      | Ensure Storage logging is enabled for Queue service for read, write and delete requests                                                                                                                  |
|  4 | CKV_AZURE_36 | /azure/storage.tf         | azurerm_storage_account_network_rules.test           | Ensure 'Trusted Microsoft Services' is enabled for Storage Account access                                                                                                                                |
|  5 | CKV_AZURE_39 | /azure/roles.tf           | azurerm_role_definition.example                      | Ensure that no custom subscription owner roles are created                                                                                                                                               |
|  6 | CKV_AZURE_14 | /azure/app_service.tf     | azurerm_app_service.app-service1                     | Ensure web app redirects all HTTP traffic to HTTPS in Azure App Service                                                                                                                                  |
|  7 | CKV_AZURE_18 | /azure/app_service.tf     | azurerm_app_service.app-service1                     | Ensure that 'HTTP Version' is the latest if used to run the web app                                                                                                                                      |
|  8 | CKV_AZURE_16 | /azure/app_service.tf     | azurerm_app_service.app-service1                     | Ensure that Register with Azure Active Directory is enabled on App Service                                                                                                                               |
|  9 | CKV_AZURE_17 | /azure/app_service.tf     | azurerm_app_service.app-service1                     | Ensure the web app has 'Client Certificates (Incoming client certificates)' set                                                                                                                          |
| 10 | CKV_AZURE_13 | /azure/app_service.tf     | azurerm_app_service.app-service1                     | Ensure App Service Authentication is set on Azure App Service                                                                                                                                            |
| 11 | CKV_AZURE_15 | /azure/app_service.tf     | azurerm_app_service.app-service1                     | Ensure web app is using the latest version of TLS encryption                                                                                                                                             |
| 12 | CKV_AZURE_18 | /azure/app_service.tf     | azurerm_app_service.app-service2                     | Ensure that 'HTTP Version' is the latest if used to run the web app                                                                                                                                      |
| 13 | CKV_AZURE_16 | /azure/app_service.tf     | azurerm_app_service.app-service2                     | Ensure that Register with Azure Active Directory is enabled on App Service                                                                                                                               |
| 14 | CKV_AZURE_17 | /azure/app_service.tf     | azurerm_app_service.app-service2                     | Ensure the web app has 'Client Certificates (Incoming client certificates)' set                                                                                                                          |
| 15 | CKV_AZURE_13 | /azure/app_service.tf     | azurerm_app_service.app-service2                     | Ensure App Service Authentication is set on Azure App Service                                                                                                                                            |
| 16 | CKV_AZURE_42 | /azure/key_vault.tf       | azurerm_key_vault.example                            | Ensure the key vault is recoverable                                                                                                                                                                      |
| 17 | CKV_AZURE_40 | /azure/key_vault.tf       | azurerm_key_vault_key.generated                      | Ensure that the expiration date is set on all keys                                                                                                                                                       |
| 18 | CKV_AZURE_41 | /azure/key_vault.tf       | azurerm_key_vault_secret.secret                      | Ensure that the expiration date is set on all secrets                                                                                                                                                    |
| 19 | CKV_AZURE_23 | /azure/sql.tf             | azurerm_sql_server.example                           | Ensure that 'Auditing' is set to 'On' for SQL servers                                                                                                                                                    |
| 20 | CKV_AZURE_24 | /azure/sql.tf             | azurerm_sql_server.example                           | Ensure that 'Auditing' Retention is 'greater than 90 days' for SQL servers                                                                                                                               |
| 21 | CKV_AZURE_27 | /azure/sql.tf             | azurerm_mssql_server_security_alert_policy.example   | Ensure that 'Email service and co-administrators' is 'Enabled' for MSSQL servers                                                                                                                         |
| 22 | CKV_AZURE_26 | /azure/sql.tf             | azurerm_mssql_server_security_alert_policy.example   | Ensure that 'Send Alerts To' is enabled for MSSQL servers                                                                                                                                                |
| 23 | CKV_AZURE_25 | /azure/sql.tf             | azurerm_mssql_server_security_alert_policy.example   | Ensure that 'Threat Detection types' is set to 'All'                                                                                                                                                     |
| 24 | CKV_AZURE_28 | /azure/sql.tf             | azurerm_mysql_server.example                         | Ensure 'Enforce SSL connection' is set to 'ENABLED' for MySQL Database Server                                                                                                                            |
| 25 | CKV_AZURE_29 | /azure/sql.tf             | azurerm_postgresql_server.example                    | Ensure 'Enforce SSL connection' is set to 'ENABLED' for PostgreSQL Database Server                                                                                                                       |
| 26 | CKV_AZURE_32 | /azure/sql.tf             | azurerm_postgresql_configuration.thrtottling_config  | Ensure server parameter 'connection_throttling' is set to 'ON' for PostgreSQL Database Server                                                                                                            |
| 27 | CKV_AZURE_30 | /azure/sql.tf             | azurerm_postgresql_configuration.example             | Ensure server parameter 'log_checkpoints' is set to 'ON' for PostgreSQL Database Server                                                                                                                  |
| 28 | CKV_AZURE_1  | /azure/instance.tf        | azurerm_linux_virtual_machine.linux_machine          | Ensure Azure Instance does not use basic authentication(Use SSH Key Instead)                                                                                                                             |
| 29 | CKV_AZURE_8  | /azure/aks.tf             | azurerm_kubernetes_cluster.k8s_cluster               | Ensure Kube Dashboard is disabled                                                                                                                                                                        |
| 30 | CKV_AZURE_7  | /azure/aks.tf             | azurerm_kubernetes_cluster.k8s_cluster               | Ensure AKS cluster has Network Policy configured                                                                                                                                                         |
| 31 | CKV_AZURE_5  | /azure/aks.tf             | azurerm_kubernetes_cluster.k8s_cluster               | Ensure RBAC is enabled on AKS clusters                                                                                                                                                                   |
| 32 | CKV_AZURE_6  | /azure/aks.tf             | azurerm_kubernetes_cluster.k8s_cluster               | Ensure AKS has an API Server Authorized IP Ranges enabled                                                                                                                                                |
| 33 | CKV_AZURE_4  | /azure/aks.tf             | azurerm_kubernetes_cluster.k8s_cluster               | Ensure AKS logging to Azure Monitoring is Configured                                                                                                                                                     |
| 34 | CKV_AZURE_19 | /azure/security_center.tf | azurerm_security_center_subscription_pricing.pricing | Ensure that standard pricing tier is selected                                                                                                                                                            |
| 35 | CKV_AZURE_21 | /azure/security_center.tf | azurerm_security_center_contact.contact              | Ensure that 'Send email notification for high severity alerts' is set to 'On'                                                                                                                            |
| 36 | CKV_AZURE_20 | /azure/security_center.tf | azurerm_security_center_contact.contact              | Ensure that security contact 'Phone number' is set                                                                                                                                                       |
| 37 | CKV_AZURE_22 | /azure/security_center.tf | azurerm_security_center_contact.contact              | Ensure that 'Send email notification for high severity alerts' is set to 'On'                                                                                                                            |
| 38 | CKV_AZURE_37 | /azure/logging.tf         | azurerm_monitor_log_profile.logging_profile          | Ensure that Activity Log Retention is set 365 days or greater                                                                                                                                            |
| 39 | CKV_AZURE_38 | /azure/logging.tf         | azurerm_monitor_log_profile.logging_profile          | Ensure audit profile captures all the activities                                                                                                                                                         |
| 40 | CKV_AZURE_9  | /azure/networking.tf      | azurerm_network_security_group.bad_sg                | Ensure that RDP access is restricted from the internet                                                                                                                                                   |
| 41 | CKV_AZURE_10 | /azure/networking.tf      | azurerm_network_security_group.bad_sg                | Ensure that SSH access is restricted from the internet                                                                                                                                                   |
| 42 | CKV_AZURE_12 | /azure/networking.tf      | azurerm_network_watcher_flow_log.flow_log            | Ensure that Network Security Group Flow Log retention period is 'greater than 90 days'                                                                                                                   |
| 43 | CKV_AWS_7    | /aws/kms.tf               | aws_kms_key.logs_key                                 | Ensure rotation for customer created CMKs is enabled                                                                                                                                                     |
| 44 | CKV_AWS_45   | /aws/lambda.tf            | aws_lambda_function.analysis_lambda                  | Ensure no hard coded AWS access key and and secret key exists in lambda environment                                                                                                                      |
| 45 | CKV_AWS_50   | /aws/lambda.tf            | aws_lambda_function.analysis_lambda                  | X-ray tracing is enabled for Lambda                                                                                                                                                                      |
| 46 | CKV_AWS_40   | /aws/iam.tf               | aws_iam_user_policy.userpolicy                       | Ensure IAM policies are attached only to groups or roles (Reducing access management complexity may in-turn reduce opportunity for a principal to inadvertently receive or retain excessive privileges.) |
| 47 | CKV_AWS_37   | /aws/eks.tf               | aws_eks_cluster.eks_cluster                          | Ensure Amazon EKS control plane logging enabled for all log types                                                                                                                                        |
| 48 | CKV_AWS_39   | /aws/eks.tf               | aws_eks_cluster.eks_cluster                          | Ensure Amazon EKS public endpoint disabled                                                                                                                                                               |
| 49 | CKV_AWS_38   | /aws/eks.tf               | aws_eks_cluster.eks_cluster                          | Ensure Amazon EKS public endpoint not accessible to 0.0.0.0/0                                                                                                                                            |
| 50 | CKV_AWS_58   | /aws/eks.tf               | aws_eks_cluster.eks_cluster                          | Ensure EKS Cluster has Secrets Encryption Enabled                                                                                                                                                        |
| 51 | CKV_AWS_51   | /aws/ecr.tf               | aws_ecr_repository.repository                        | Ensure ECR Image Tags are immutable                                                                                                                                                                      |
| 52 | CKV_AWS_33   | /aws/ecr.tf               | aws_ecr_repository.repository                        | Ensure ECR image scanning on push is enabled                                                                                                                                                             |
| 53 | CKV_AWS_46   | /aws/ec2.tf               | aws_instance.web_host                                | Ensure no hard coded AWS access key and and secret key exists in EC2 user data                                                                                                                           |
| 54 | CKV_AWS_8    | /aws/ec2.tf               | aws_instance.web_host                                | Ensure all data stored in the Launch configuration EBS is securely encrypted                                                                                                                             |
| 55 | CKV_AWS_3    | /aws/ec2.tf               | aws_ebs_volume.web_host_storage                      | Ensure all data stored in the EBS is securely encrypted                                                                                                                                                  |
| 56 | CKV_AWS_4    | /aws/ec2.tf               | aws_ebs_snapshot.example_snapshot                    | Ensure all data stored in the EBS Snapshot is securely encrypted                                                                                                                                         |
| 57 | CKV_AWS_24   | /aws/ec2.tf               | aws_security_group.web-node                          | Ensure no security groups allow ingress from 0.0.0.0:0 to port 22                                                                                                                                        |
| 58 | CKV_AWS_21   | /aws/ec2.tf               | aws_s3_bucket.flowbucket                             | Ensure all data stored in the S3 bucket have versioning enabled                                                                                                                                          |
| 59 | CKV_AWS_52   | /aws/ec2.tf               | aws_s3_bucket.flowbucket                             | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 60 | CKV_AWS_18   | /aws/ec2.tf               | aws_s3_bucket.flowbucket                             | Ensure the S3 bucket has access logging enabled                                                                                                                                                          |
| 61 | CKV_AWS_19   | /aws/ec2.tf               | aws_s3_bucket.flowbucket                             | Ensure all data stored in the S3 bucket is securely encrypted at rest                                                                                                                                    |
| 62 | CKV_AWS_17   | /aws/db-app.tf            | aws_db_instance.default                              | Ensure all data stored in the RDS bucket is not public accessible                                                                                                                                        |
| 63 | CKV_AWS_16   | /aws/db-app.tf            | aws_db_instance.default                              | Ensure all data stored in the RDS is securely encrypted at rest                                                                                                                                          |
| 64 | CKV_AWS_23   | /aws/db-app.tf            | aws_security_group.default                           | Ensure every security groups rule has a description                                                                                                                                                      |
| 65 | CKV_AWS_23   | /aws/db-app.tf            | aws_security_group_rule.ingress                      | Ensure every security groups rule has a description                                                                                                                                                      |
| 66 | CKV_AWS_23   | /aws/db-app.tf            | aws_security_group_rule.egress                       | Ensure every security groups rule has a description                                                                                                                                                      |
| 67 | CKV_AWS_8    | /aws/db-app.tf            | aws_instance.db_app                                  | Ensure all data stored in the Launch configuration EBS is securely encrypted                                                                                                                             |
| 68 | CKV_AWS_41   | /aws/providers.tf         | aws                                                  | Ensure no hard coded AWS access key and and secret key exists in provider                                                                                                                                |
| 69 | CKV_AWS_5    | /aws/es.tf                | aws_elasticsearch_domain.monitoring-framework        | Ensure all data stored in the Elasticsearch is securely encrypted at rest                                                                                                                                |
| 70 | CKV_AWS_20   | /aws/s3.tf                | aws_s3_bucket.data                                   | S3 Bucket has an ACL defined which allows public READ access.                                                                                                                                            |
| 71 | CKV_AWS_21   | /aws/s3.tf                | aws_s3_bucket.data                                   | Ensure all data stored in the S3 bucket have versioning enabled                                                                                                                                          |
| 72 | CKV_AWS_52   | /aws/s3.tf                | aws_s3_bucket.data                                   | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 73 | CKV_AWS_18   | /aws/s3.tf                | aws_s3_bucket.data                                   | Ensure the S3 bucket has access logging enabled                                                                                                                                                          |
| 74 | CKV_AWS_19   | /aws/s3.tf                | aws_s3_bucket.data                                   | Ensure all data stored in the S3 bucket is securely encrypted at rest                                                                                                                                    |
| 75 | CKV_AWS_21   | /aws/s3.tf                | aws_s3_bucket.financials                             | Ensure all data stored in the S3 bucket have versioning enabled                                                                                                                                          |
| 76 | CKV_AWS_52   | /aws/s3.tf                | aws_s3_bucket.financials                             | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 77 | CKV_AWS_18   | /aws/s3.tf                | aws_s3_bucket.financials                             | Ensure the S3 bucket has access logging enabled                                                                                                                                                          |
| 78 | CKV_AWS_19   | /aws/s3.tf                | aws_s3_bucket.financials                             | Ensure all data stored in the S3 bucket is securely encrypted at rest                                                                                                                                    |
| 79 | CKV_AWS_52   | /aws/s3.tf                | aws_s3_bucket.operations                             | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 80 | CKV_AWS_18   | /aws/s3.tf                | aws_s3_bucket.operations                             | Ensure the S3 bucket has access logging enabled                                                                                                                                                          |
| 81 | CKV_AWS_19   | /aws/s3.tf                | aws_s3_bucket.operations                             | Ensure all data stored in the S3 bucket is securely encrypted at rest                                                                                                                                    |
| 82 | CKV_AWS_52   | /aws/s3.tf                | aws_s3_bucket.data_science                           | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 83 | CKV_AWS_19   | /aws/s3.tf                | aws_s3_bucket.data_science                           | Ensure all data stored in the S3 bucket is securely encrypted at rest                                                                                                                                    |
| 84 | CKV_AWS_52   | /aws/s3.tf                | aws_s3_bucket.logs                                   | Ensure S3 bucket has MFA delete enabled                                                                                                                                                                  |
| 85 | CKV_AWS_18   | /aws/s3.tf                | aws_s3_bucket.logs                                   | Ensure the S3 bucket has access logging enabled                                                                                                                                                          |

---

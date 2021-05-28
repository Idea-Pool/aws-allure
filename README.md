# AWS-ALLURE REPORTING
This repository holds the sources to create a centralized reporting service using Terraform, Allure, Docker and AWS.

## Prerequisites
1. Terraform installed.
2. AWS CLI installed.
3. Default AWS profile configured (through environment variables, ex: `export AWS_PROFILE=my_aws_user`). This profile needs admin priviliges in AWS (EC2 instance creation, security group creation)
4. A key pair created in the AWS console, and saved as `allure.pem` to the `terraform` folder.

## Setup steps

To initialize the terraform project, go into the `terraform` directory and:
1. Execute `terraform init`, this will initialize the project, downloading the necessary cloud provider plugins, in this case AWS.
2. Execute `terraform plan` to see what will terraform do using your default AWS account.
3. Execute `terraform apply` to deploy the Allure server to an EC2 instance.
4. To clean up everything in AWS, destroy the created resources, execute `terraform destroy`.
5. If you want to destroy only the EC2 instance, you can execute `terraform destroy -target aws_instance.AllureAwsInstance`.
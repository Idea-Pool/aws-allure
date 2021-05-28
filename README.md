# AWS-ALLURE REPORTING
This repository holds the sources to create a centralized reporting service in AWS with Allure and Docker using Terraform.  
  
**Please look at this repository as a proof of concept only. It is not a production ready solution.**  
  
The base of this project is two other projects maintained by Frank Escobar.  
- Allure-service: https://github.com/fescobar/allure-docker-service  
- Allure-ui: https://github.com/fescobar/allure-docker-service-ui 

The Terraform scripts in this repository create an AWS EC2 instance and deploy the Allure-service and Allure-ui on the instance.  
The deployment is done by installing Docker and Docker Compose onto the EC2 instance, copying over the docker-compose.yml, and executing it.  
   
After deployment:  
- The UI is available on port 80.  
- The Service is available on port 5050.  
- SSH to the instance is enabled.  

## Prerequisites

1. Terraform installed.
2. AWS CLI installed.
3. Default AWS profile configured (through environment variables, ex: `export AWS_PROFILE=my_aws_user`). This profile needs admin priviliges in AWS (EC2 instance creation, security group creation)
4. A key pair created in the AWS console, and saved as `allure.pem` to the `terraform` folder.

## Setup steps

Execute the following steps in the `terraform` directory:
1. `terraform init`, to initialize the project, downloading the necessary cloud provider plugins, in this case AWS.
2. `terraform plan`, to see what will terraform do using your default AWS account.
3. `terraform apply`, to deploy the Allure server to an EC2 instance.
  
Additionally: 
- `terraform destroy`, to clean up everything in AWS, destroy the created resources.  
- `terraform destroy -target aws_instance.AllureAwsInstance`, to destroy only the EC2 instance.  

## To improve

1. Use custom AMIs instead of provisioners in Terraform.
2. Use AWS SDK/CDK instead of Terraform, and deploy the application into ECS instead of EC2.
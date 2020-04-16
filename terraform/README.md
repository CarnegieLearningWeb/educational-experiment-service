### terraform script for creating infrastructure for upgrade using docker image


# How to use it
Download and install [Terraform](https://www.terraform.io/downloads.html) & [EB CLI](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install-advanced.html) on your system.

Clone this repo using `git clone https://github.com/dhavalocked/terraform.git`

Setup a aws provider profile using `aws configure`

Generate ssh key using `ssh-keygen -f mykey` (if you generate it with a different name, make sure to replace variables inside **vars.tf** )

 Once downloaded, use `terraform init` to initialize the project and `terraform apply to create infrastructure.
 
 
 AWS Resources that will be created by this script.
 
 -  Elastic beanstalk environment
 -  RDS (postgres)
 -  Step function 
 -  Lambda function
 -  Elastic Load Balancer
 -  Auto scaling group
 
 Once the environment setup is successfull, You can deploy docker image using eb-cli.
 
 Use `eb init` to initialize your app and then `eb deploy` using your docker file.
 
 # Sample Dockerrun.aws.json file
 
 ```JSON
{
  "AWSEBDockerrunVersion": "1",
  "Image": {
    "Name": "public docker image link or ECR docker image link",
    "Update": "true"
  },
  "Ports": [
    {
      "ContainerPort": "3030"
    }
  ],
  "Volumes": [],
  "Logging": "/var/log/eb-activity.log"
}
```

 
 

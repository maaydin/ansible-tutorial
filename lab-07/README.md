# Infrastructure 

Provision scripts create dev and production environments for greeting application.

---

## Building Environments

**1. Building Training Environment**

> **Notes:**
> 
> - Ensure [Python](https://www.python.org/ftp/python/2.7.5/) (2.7.5 recommended) is installed.
> - Ensure [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (5.1.6 recommended)  is installed.
> - Ensure [Vagrant](https://www.vagrantup.com/downloads.html) (1.8.6 recommended) is installed.
> - Ensure [Ansible](http://docs.ansible.com/ansible/intro_installation.html) (2.1.1 recommended) is installed.
> - Windows isn’t supported

* Ensure *static.zip* artifact present on path *provision/roles/deploy_static_content/files*
* Ensure *greeting-version.jar* artifact present on path  *provision/roles/deploy_application/files*
* Run below command to initialize your training environment on your terminal
```sh
cd /path/to/project
vagrant up
```
* Run below command to roll updates
```sh
vagrant provision
```

**2. Building Production Environment**

> **Notes:**
> 
> - Ensure [Python](https://www.virtualbox.org/wiki/Downloads) (2.7.5 recommended) is installed.
> - Ensure [Python-boto](https://github.com/boto/boto) (2.38.0 recommended) is installed.
> - Ensure [Ansible](http://docs.ansible.com/ansible/intro_installation.html) (2.1.1 recommended) is installed.
> - Ensure [Packer](https://www.packer.io/downloads.html) (0.10.2 recommended) is installed.
> - Create an IAM user in AmazonEC2FullAccess policy and create an access key for this user. Visit [Creating an IAM User in Your AWS Account](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html) for help on creating a user.
> - Ensure *AWS_ACCESS_KEY_ID* and *AWS_SECRET_ACCESS_KEY* is set on your environment variables or directly in build scripts. Visit [Getting Your Access Key ID and Secret Access Key](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html) for help on creating keys.
> - Create 2 subnets at *eu-west-1* (Frankfurt) region in different availability zones on [AWS Console](https://aws.amazon.com/) and edit subnet information at configuration file on path *provision/environments/aws.yml*

**2.1 Creating Amazon Machine Image (AMI)**

* Ensure *static.zip* artifact present on path *provision/roles/deploy_static_content/files*
* Ensure *greeting-version.jar* artifact present on path  *provision/roles/deploy_application/files*
* Run below command to create an image on
```sh
cd /path/to/project
bash -c bin/aws-create-image.sh
```
* Note the AMI image-id on packer standard output to use in next steps

**2.2 Creating Infrastructure on AWS for first time**
> **Notes:**
> 
> - Below command will create below settings on your AWS account.
>  - A VPC Security Group that allows traffic on port TCP(80) from any address to any address for the Elastic Load Balancer
>  - An Elastic Load Balancer that listens on port TCP(80)
>  - A VPC Security Group that allows traffic on port TCP(80) from any -internal- address to the instances
>  - A Launch Configuration for given image
>  - An Auto Scaling Group with Scale Up & Down policies
> - Also 2 new EC2 Instances will be created via Auto Scale

* Ensure configurations are correct in configuration file on path *provision/environments/aws.yml*
* Run below command to initialize infrastructure
```sh
cd /path/to/project
bash -c bin/aws-init.sh <image-id>
```
* Get the dns name of Elastic Loadbalancer such as *greeting-lb-prod-123456789.eu-west-1.elb.amazonaws.com* on command's standard output.
* Browse to the dns name to test the application

**2.3 Rolling Updates on an Already Created Infrastructure on AWS**
> **Notes:**
> 
> - Below command will create below settings on your AWS account.
>  - A VPC Security Group that allows traffic on port TCP(80) from any -internal- address to the instances
>  - A Launch Configuration for given image
>  - An Auto Scaling Group with Scale Up & Down policies
> - Also current EC2 Instances will be replaced

* Ensure configurations are correct in configuration file on path *provision/environments/aws.yml*
* Run below command to initialize infrastructure
```sh
cd /path/to/project
bash -c bin/aws-update.sh <image-id>
```
* Dns name of Elastic Loadbalancer does not changes on this step. Still you can get the dns name of Elastic Loadbalancer such as *greeting-lb-prod-123456789.eu-west-1.elb.amazonaws.com* on command's standard output.
* Browse to the dns name to test the application

---

## Images Needed to Build Environments
Below the list of images to create environments. You don't need to download images manually.

* [Production Env. Image](http://aws.amazon.com/marketplace/pp?sku=aw0evgkw8e5c1q413zgy5pjce)
* [Dev Env. Image](https://atlas.hashicorp.com/puppetlabs/boxes/centos-7.0-64-nocm)

## Scaling Plan

Production deployment scripts creates an auto scaling plan on AWS. Auto scaling plan starts with 2 instances and can scale up / downbetween 2-8 instances automatically. 

Auto scaling scales up / down instances based on CPU utilization. When a CPU utilization threshold with more then 50 percent achieved it automatically increases the number of instances by 1 in the cluster. When a CPU utilization threshold with less then 20 percent achieved it automatically decreases the number of instances by 1 in the cluster.

Auto Scaling configuration can be updated at configuration file on path *provision/environments/aws.yml* and can be applied to production as described on **2.3 Rolling Updates on an Already Created Infrastructure on AWS** step.

Visit [Auto Scaling Documentation](http://aws.amazon.com/documentation/autoscaling/) for detailed information.
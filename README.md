fender-elasticsearch
====================

Creates a 3 node Elasticsearch cluster in EC2 within it's own VPC using terraform. The kopf plugin will be installed on each node. These nodes are in a private subnet.

A proxy instance is created which allows access to the kopf interface; http://proxy_dns_or_ip:8080/kopf/

Prerequisites
-------------
Terraform - can be installed via homebrew: `brew update && brew install terraform`

Usage
-----
Clone the repository.
```
git clone git@github.com:dgoradia/fd-elasticsearch.git
cd fd-elasticsearch/terraform
```

Create a file named `terraform.tfvars` in the terraform directory with your AWS credentials.
```
access_key = "ACCESS_KEY_ID"
secret_key = "SECRET_ACCESS_KEY"
```

Generate a deployment ssh key pair.
```
ssh-keygen -t rsa -C "insecure-deploy" -P '' -f ssh/insecure-deploy
```

Let's create those nodes!
------------------------
```
terraform apply
```

Once the resources are created, a Chef converge will begin within each node. This can take 5 - 10 mins before they are available.

To teardown the resources just give the destroy command:
```
terraform destroy
```

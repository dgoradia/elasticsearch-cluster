variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret key"
}

variable "region" {
  description = "AWS region"
  default = "us-west-2"
}

variable "vpc_cidr" {
  description = "VPC network"
  default = "10.68.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Private subnet network"
  default = "10.68.0.0/24"
}

variable "private_subnet_cidr" {
  description = "Private subnet network"
  default = "10.68.1.0/24"
}

variable "elb_lb_protocol" {
  description = "ELB listener lb protocol"
  default = "http"
}

variable "elb_lb_port" {
  description = "ELB listener lb port"
  default = 9200
}

variable "elb_instance_protocol" {
  description = "ELB listener instance protocol"
  default = "http"
}

variable "elb_instance_port" {
  description = "ELB listener instance port"
  default = 9200
}

variable "elb_check_healthy" {
  description = "ELB healthy threshold"
  default = 6
}

variable "elb_check_unhealthy" {
  description = "ELB unhealthy threshold"
  default = 2
}

variable "elb_check_target" {
  description = "Target for ELB health checks"
  default = "HTTP:9200/_cluster/health"
}

variable "elb_check_interval" {
  description = "ELB health check interval"
  default = 30
}

variable "elb_check_timeout" {
  description = "ELB health check timeout"
  default = 5
}

variable "amis" {
  description = "AMIs"
  default = {
    us-east-1 = "ami-fce3c696"
    us-west-1 = "ami-06116566"
    us-west-2 = "ami-9abea4fb"
  }
}

variable "dru_ip" {
  description = "Dru's IP address"
  default = "76.171.11.240"
}

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "ec2_cluster" {
  source = "./modules/ec2_instances"

  ami_id    = var.ami_id
  instances = var.instances
}
terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 1. Standard instances (4 instances driven by for_each)
resource "aws_instance" "standard" {
  for_each = { for k, v in var.instances : k => v if k != "db-primary" }

  ami           = var.ami_id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  root_block_device {
    volume_type = each.value.root_block_device_type
    volume_size = each.value.root_block_size
    iops        = lookup(each.value, "iops", null)
  }

  tags = {
    Name        = each.key
    Environment = each.value.environment
    Owner       = each.value.owner
  }
}

# 2. Dedicated database instance with literal prevent_destroy = true
resource "aws_instance" "db_primary" {
  ami           = var.ami_id
  instance_type = var.instances["db-primary"].instance_type
  key_name      = var.instances["db-primary"].key_name

  root_block_device {
    volume_type = var.instances["db-primary"].root_block_device_type
    volume_size = var.instances["db-primary"].root_block_size
    iops        = var.instances["db-primary"].iops
  }

  lifecycle {
    prevent_destroy = true # Literal constant required by Terraform
  }

  tags = {
    Name        = "db-primary"
    Environment = var.instances["db-primary"].environment
    Owner       = var.instances["db-primary"].owner
  }
}

terraform {
  backend "s3" {
    bucket         = "arrise-terraform-state"
    key            = "task-1-ec2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "arrise-terraform-locks"
    encrypt        = true
  }
}

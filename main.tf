# main.tf

# AWS Provider Configuration
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Billing        = var.billing_tag
      CreatedBy      = var.created_by_tag
      CustomerFacing = var.is_customer_facing
      Environment    = var.environment
      PCI            = var.pci_tag
    }
  }
}

terraform {
  # Specify supported versions of Terraform
  required_version = ">= 1.0.0"

  # State file is in S3, lock is in dynamo DB
  backend "s3" {
      bucket         = "pete-k-may-terraform-state"
      dynamodb_table = "terraform-state"
      region         = "ap-southeast-2"
      key            = "public-website.tfstate"
  }
}

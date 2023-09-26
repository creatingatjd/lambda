terraform {
  required_version = ">= 1.0.0"
  required_providers {
      aws = {
      source = "hashicorp/aws"
      version = "5.10.0" # Use an appropriate version constraint

    }
  }
}
provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

    # Replace this with your desired AWS region
  # Other optional configuration settings can be added here if needed
}
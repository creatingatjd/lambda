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
  region = "eu-west-2"
  access_key = "AKIA4H4ZNMOLO34UY6CW"
  secret_key = "fO6nLvi0LHfsGMk3tA8QI93kXEkJaJ78PYUGvlD1"

    # Replace this with your desired AWS region
  # Other optional configuration settings can be added here if needed
}

module "aws_lambda" {
  source            = "./module-lambda/"
  aws_iam_role = "inventory_iam_role"
  aws_iam_policy = "inventory_iam_policy"
  aws_lambda_function = "inventory_lambda_function_name"
  aws_lambda_function_handler = "hello.lambda_handler"
}




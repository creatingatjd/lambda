module "aws_lambda" {
  source                      = "./module-lambda/"
  aws_iam_role                = var.aws_iam_role
  aws_iam_policy              = var.aws_iam_policy
  aws_lambda_function         = var.aws_lambda_function
  aws_lambda_function_handler = var.aws_lambda_function_handler
  
}



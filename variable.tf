variable "aws_iam_role" {
    type = string
    description = "creating iam role"
}

variable "aws_iam_policy" {
    type = string
    description = "creating iam policy"
}

variable "aws_lambda_function" {
    type = string
    description = "creating lambda function"
}
variable "aws_lambda_function_handler" {
    type = string
    description = "creating aws_lambda_function_handler"
}
variable "aws_region" {
    type = string
    description = "creating lambda function in this region"
}

variable "aws_access_key" {
    type = string
    description = "access_key for aws account"
}
variable "aws_secret_key" {
    type = string
    description = "secret_key for aws account"
}
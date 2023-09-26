resource "aws_iam_user" "example_user" {
  name = "example-user"
}

resource "aws_iam_policy" "example_policy" {
  name        = "ExamplePolicy"
  description = "Policy to allow IAM role and policy creation"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CreateIAMRoles",
      "Effect": "Allow",
      "Action": [
        "iam:CreateRole",
        "iam:GetRole",
        "iam:PutRolePolicy",
        "iam:AttachRolePolicy"
      ],
      "Resource": "*"
    },
    {
      "Sid": "CreateIAMPolicies",
      "Effect": "Allow",
      "Action": [
        "iam:CreatePolicy",
        "iam:GetPolicy",
        "iam:GetPolicyVersion",
        "iam:CreatePolicyVersion",
        "iam:AttachUserPolicy"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "example_attachment" {
  user       = aws_iam_user.example_user.name
  policy_arn = aws_iam_policy.example_policy.arn
}


// resource "aws_iam_role" "lambda_role" {
//   name               = var.aws_iam_role
//   assume_role_policy = jsonencode({
//     Version = "2012-10-17"
//     Statement = [
//       {
//         Action = "sts:AssumeRole"
//         Effect = "Allow"
//         Sid    = ""
//         Principal = {
//           Service = "lambda.amazonaws.com"
//         }
//       },
//     ]
//   })

//   tags = {
//     tag-key = "tag-value"
//   }
// }


// resource "aws_iam_policy" "lambda_policy" {
//   name        = var.aws_iam_policy
//   path        = "/"
//   description = "IAM policy for managing aws lambda role"
//   policy = jsonencode({

//   Version: "2012-10-17",
//   Statement: [
//     {
//       "Sid": "Stmt1695377896379",
//       "Action": [
//         "logs:CreateLogGroup",
//         "logs:CreateLogStream",
//         "logs:DescribeLogGroups",
//         "logs:DescribeLogStreams",
//         "logs:PutLogEvents",
//         "logs:PutRetentionPolicy"
//       ],
//       "Effect": "Allow",
//       "Resource": "*"
        
//     }
//     ]
//   })
// }

// resource "aws_iam_role_policy_attachment" "lambda_policy_role_attachment" {
//   role       = aws_iam_role.lambda_role.name
//   policy_arn = aws_iam_policy.lambda_policy.arn
// }


data "archive_file" "lambda_archive_file" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/hello.zip"
}

resource "aws_lambda_function" "lambda_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${path.module}/python/hello.zip"
  function_name = "inventory_lambda_function"
  user          = aws_iam_user.example_user.arn
  handler       = "hello.lambda_handler"
  source_code_hash = data.archive_file.lambda_archive_file.output_base64sha256
  runtime = "python3.9"
  depends_on = [aws_iam_role_policy_attachment.example_attachment ]
  // vpc_config {
  //   subnet_ids         = [aws_subnet.example_subnet.id] # Use the subnet ID(s) you defined
  //   security_group_ids = [aws_security_group.example_security_group.id] # Specify your security group(s)
  // }
}
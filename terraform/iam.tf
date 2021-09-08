resource "aws_iam_role" "iam_role_for_python_picture_lambda" {
  name = "iam_for_python_picture_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam_role_policy_for_python_picture_lambda"{
    name = "iam_role_policy_for_python_picture_lambda"
    role = aws_iam_role.iam_role_for_python_picture_lambda.name
    policy = data.template_file.iam_lambda_access_role_policy.rendered
}

# To enable lambda to write to cloudwatch logs
resource "aws_iam_policy_attachment" "attach_AWSLambdaBasicExecutionRole" {
  name       = "attach_AWSLambdaBasicExecutionRole"
  roles      = [aws_iam_role.iam_role_for_python_picture_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
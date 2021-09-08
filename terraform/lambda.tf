resource "aws_lambda_function" "python_picture_lambda" {
  filename      = "python_exif_data_remover.zip"
  function_name = local.lambda_name
  role          = aws_iam_role.iam_role_for_python_picture_lambda.arn
  handler       = "main.handler"

  timeout = 10
  memory_size = 256

  source_code_hash = data.archive_file.lambda_python_exif_data_remover.output_base64sha256

  runtime = "python3.9"

  environment {
    variables = {
      bucketB = var.BUCKET_NAME_B
    }
  }
}


# Gives an external source (like a CloudWatch Event Rule, SNS, or S3) 
# permission to access the Lambda function.
resource "aws_lambda_permission" "allow_bucket_trigger_lambda" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.python_picture_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket-a.arn
}
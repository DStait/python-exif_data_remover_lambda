resource "aws_s3_bucket" "bucket-a" {
  bucket = var.BUCKET_NAME_A
  acl    = "private"

  tags = {
    Name        = var.BUCKET_NAME_A
  }
}

resource "aws_s3_bucket" "bucket-b" {
  bucket = var.BUCKET_NAME_B
  acl    = "private"

  tags = {
    Name        = var.BUCKET_NAME_B
  }
}

resource "aws_s3_bucket_notification" "python_picture_lambda_trigger" {
  bucket = var.BUCKET_NAME_A

  lambda_function {
      lambda_function_arn = "${aws_lambda_function.python_picture_lambda.arn}"
      events              = ["s3:ObjectCreated:*"]
      filter_suffix       = ".jpg"
  }
}
# Create the ZIP file for lambda
data "archive_file" "lambda_python_exif_data_remover" {
  type        = "zip"
  source_dir  = "${path.module}/../python_exif_data_remover"
  output_path = "${path.module}/python_exif_data_remover.zip"
}

# IAM role policy template
data "template_file" "iam_lambda_access_role_policy" {
    template = file("${path.module}/files/iam_lambda_access_policy.json")

    vars = {
        BUCKET_NAME_A = var.BUCKET_NAME_A
        BUCKET_NAME_B = var.BUCKET_NAME_B
    }
}

# IAM User A policy template
data "template_file" "iam_user_a_access_role_policy" {
    template = file("${path.module}/files/iam_user_a_policy.json")

    vars = {
        BUCKET_NAME_A = var.BUCKET_NAME_A
    }
}

# IAM User B policy template
data "template_file" "iam_user_b_access_role_policy" {
    template = file("${path.module}/files/iam_user_b_policy.json")

    vars = {
        BUCKET_NAME_B = var.BUCKET_NAME_B
    }
}
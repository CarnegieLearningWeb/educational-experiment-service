
data "archive_file" "upgrade-lambdas" {
  type        = "zip"
  source_dir  = "lambdas"
  output_path = "lambdas.zip"
}

resource "aws_lambda_function" "upgrade-schedular" {
  filename         = "lambdas.zip"
  function_name    = "tf-${terraform.workspace}-handler"
  role             = aws_iam_role.upgrade-iam_for_lambda.arn
  handler          = "handler.schedule"
  source_code_hash = fileexists("lambdas.zip") ? base64sha256(filebase64("lambdas.zip")) : null
  runtime          = var.runtime
  depends_on = [data.archive_file.upgrade-lambdas]
}
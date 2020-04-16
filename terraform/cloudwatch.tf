resource "aws_cloudwatch_log_group" "schedular" {
  name    = "/aws/lambda/${aws_lambda_function.schedular.function_name}"
}

resource "aws_cloudwatch_log_stream" "schedular-log-stream" {
  name           = "schedular-log-stream"
  log_group_name = aws_cloudwatch_log_group.schedular.name
}
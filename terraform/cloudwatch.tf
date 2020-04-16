resource "aws_cloudwatch_log_group" "upgrade-schedular" {
  name    = "/aws/lambda/${aws_lambda_function.upgrade-schedular.function_name}"
}

resource "aws_cloudwatch_log_stream" "upgrade-schedular-log-stream" {
  name           = "schedular-log-stream"
  log_group_name = aws_cloudwatch_log_group.upgrade-schedular.name
}
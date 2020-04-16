resource "aws_sfn_state_machine" "ExperimentSchedular-development" {
  name     = "experimentSchedular-development"
  role_arn = aws_iam_role.iam_for_sfn.arn

  definition = <<EOF
  {
  "Comment": "Experiment schedular development mode",
  "StartAt": "InitialState",
  "States": {
    "InitialState": {
      "Type": "Wait",
      "TimestampPath": "$.timeStamp",
      "Next": "FinalState"
    },
    "FinalState": {
      "Type": "Task",
      "Resource": "${aws_lambda_function.schedular.arn}",
      "End": true
    }
  }
}
EOF
}
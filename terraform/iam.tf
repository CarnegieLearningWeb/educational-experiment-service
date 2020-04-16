# iam roles
resource "aws_iam_role" "app-ec2-role" {
  name               = "app-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "app-ec2-role" {
  name = "app-ec2-role"
  role = aws_iam_role.app-ec2-role.name
}

# service
resource "aws_iam_role" "elasticbeanstalk-service-role" {
  name = "elasticbeanstalk-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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

resource "aws_iam_role" "iam_for_sfn" {
  name = "iam_for_sfn"
  assume_role_policy = data.aws_iam_policy_document.sfn_assume_role_policy_document.json
}

data "aws_iam_policy_document" "sfn_assume_role_policy_document" {

  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "states.eu-west-1.amazonaws.com",
        "events.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy" "lambda-execution" {
  name        = "lambda-execution"
  role   = aws_iam_role.iam_for_sfn.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "lambda:InvokeFunction",
        "states:StartExecution"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
# policies
resource "aws_iam_policy_attachment" "app-attach1" {
name       = "app-attach1"
roles      = [aws_iam_role.app-ec2-role.name]
policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_policy_attachment" "app-attach2" {
name       = "app-attach2"
roles      = [aws_iam_role.app-ec2-role.name]
policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_policy_attachment" "app-attach3" {
name       = "app-attach3"
roles      = [aws_iam_role.app-ec2-role.name]
policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_policy_attachment" "app-attach4" {
name       = "app-attach4"
roles      = [aws_iam_role.elasticbeanstalk-service-role.name]
policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

resource "aws_iam_policy_attachment" "app-attach5" {
name       = "app-attach5"
roles      = [aws_iam_role.app-ec2-role.name]
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_policy_attachment" "app-attach6" {
name       = "app-attach6"
roles      = [aws_iam_role.elasticbeanstalk-service-role.name]
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


resource "aws_cloudwatch_metric_alarm" "low_activity_alarm" {
  alarm_name          = "LowActivityAlarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 4
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Destruir recursos após 20 minutos de inatividade"
  dimensions = {
    InstanceId = var.instance_id
  }
  alarm_actions = [aws_lambda_permission.allow_invoke_lambda.arn]
}

resource "aws_lambda_function" "destroy_all_infra" {
  filename         = "${path.module}/function/lambda_function.zip"
  function_name    = "DestroyAllInfraFunction"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_function.handler"
  runtime          = "python3.8"

  environment {
    variables = {
      TERRAFORM_DIR = "/path/to/your/terraform/files"  # Caminho dos arquivos Terraform
    }
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ],
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:TerminateInstances",
          "rds:DeleteDBInstance",
          "elasticloadbalancing:DeleteLoadBalancer",
          "s3:DeleteBucket",
          "cloudwatch:DeleteAlarms",
          "lambda:DeleteFunction",
          "cloudformation:DeleteStack",
          "iam:DeleteRole",
          "iam:DeleteRolePolicy",
        ],
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

resource "aws_lambda_permission" "allow_invoke_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.destroy_all_infra.function_name
  principal     = "cloudwatch.amazonaws.com"
}

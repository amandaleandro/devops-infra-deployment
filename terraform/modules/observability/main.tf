resource "aws_cloudwatch_log_group" "app_log_group" {
  name = "app-log-group"
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name                = "high-cpu-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods         = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ec2 instance cpu utilization"

  dimensions = {
    InstanceId = aws_instance.wordpress.id
  }

  actions_enabled = true
}

variable "instance_id" {
  description = "Instance ID"
  type        = string
}

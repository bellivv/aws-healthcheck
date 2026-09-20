resource "aws_cloudwatch_log_metric_filter" "monitor_down" {
  name           = "${var.project_name}-monitor-down"
  log_group_name = module.ecs.log_group_name
  pattern        = "ALERT"

  metric_transformation {
    name          = "MonitorDownEvents"
    namespace     = "AWSHealthCheck"
    value         = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_metric_alarm" "monitor_down" {
  alarm_name          = "${var.project_name}-monitor-down"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = aws_cloudwatch_log_metric_filter.monitor_down.metric_transformation[0].name
  namespace           = aws_cloudwatch_log_metric_filter.monitor_down.metric_transformation[0].namespace
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "Fires when the checker logs an ALERT (a monitored URL is down)"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]

  tags = {
    Project = var.project_name
  }
}
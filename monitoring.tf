# CPU Alert
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "prod-rds-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "RDS CPU over 80% for 10 minutes"
  alarm_actions       = [var.sns_topic_arn]
  treat_missing_data  = "missing"  # Added missing parameter

  dimensions = {
    DBInstanceIdentifier = module.rds.db_instance_identifier  # Fixed from db_instance_identifier to db_instance_id
  }
}

# Storage Alert
resource "aws_cloudwatch_metric_alarm" "low_storage" {
  alarm_name          = "prod-rds-low-storage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 600
  statistic           = "Minimum"
  threshold           = 10737418240  # 10GB
  alarm_description   = "RDS storage under 10GB free"
  alarm_actions       = [var.sns_topic_arn]
  treat_missing_data  = "breaching"  # Added missing parameter

  dimensions = {
    DBInstanceIdentifier = module.rds.db_instance_identifier  # Fixed from db_instance_identifier to db_instance_id
  }
}
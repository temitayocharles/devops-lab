output "sns_topic_arn" {
  description = "ARN of the SNS topic used for budget alerts"
  value       = aws_sns_topic.budget_alert_topic.arn
}

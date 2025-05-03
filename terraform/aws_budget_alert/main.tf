resource "aws_sns_topic" "budget_alert_topic" {
  name = var.sns_topic_name
  tags = var.tags
}

resource "aws_sns_topic_subscription" "email_subscriptions" {
  for_each = toset(var.notification_emails)

  topic_arn = aws_sns_topic.budget_alert_topic.arn
  protocol  = "email"
  endpoint  = each.value
}

resource "aws_budgets_budget" "monthly_budget" {
  name              = var.budget_name
  budget_type       = "COST"
  limit_amount      = var.monthly_limit
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = var.time_period_start

  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 80
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_sns_topic_arns = [aws_sns_topic.budget_alert_topic.arn]
  }

  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 100
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_sns_topic_arns = [aws_sns_topic.budget_alert_topic.arn]
  }

  tags = var.tags
}

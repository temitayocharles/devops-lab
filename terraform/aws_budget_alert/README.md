# AWS Budget Alert Module

This Terraform module provisions:
- A $200 monthly AWS budget
- Two alert thresholds: 80% and 100%
- An SNS topic for budget notifications
- Email subscriptions to receive alerts

## 💼 Usage

```hcl
module "budget_alert" {
  source = "../modules/aws_budget_alert"

  budget_name         = "sandbox-monthly-budget"
  monthly_limit       = "200"
  time_period_start   = "2025-05-01"
  sns_topic_name      = "sandbox-budget-alert-topic"
  notification_emails = [
    "s9charles.wft@gmail.com",
    "s9sophia.wft@gmail.com",
    "s8jenny.wft@gmail.com",
    "s8stephane.wft@gmail.com",
    "s8zoumana.wft@gmail.com",
    "s8dubois.wft@gmail.com",
    "s4clovis.wft@gmail.com"
      ]
  tags = {
    Project     = "Sandbox"
    Environment = "Dev"
    Owner       = "team-troopers"
  }
}

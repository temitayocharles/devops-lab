variable "budget_name" {
  description = "The name of the budget"
  type        = string
}

variable "monthly_limit" {
  description = "Monthly budget limit (in USD)"
  type        = string
  default     = "200"
}

variable "time_period_start" {
  description = "The start date of the budget period (YYYY-MM-DD)"
  type        = string
  default     = "2025-05-02"
}

variable "sns_topic_name" {
  description = "Name of the SNS topic for alerts"
  type        = string
  default     = "aws-budget-alert-topic"
}

variable "notification_emails" {
  description = "List of email addresses to subscribe to the budget alert topic"
  type        = list(string)
  default     = [
    "s9charles.wft@gmail.com",
    "s9sophia.wft@gmail.com",
    "s8jenny.wft@gmail.com",
    "s8stephane.wft@gmail.com",
    "s8zoumana.wft@gmail.com",
    "s8dubois.wft@gmail.com",
    "s4clovis.wft@gmail.com"
]
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "Sandbox"
    Environment = "Development"
    Owner       = "Webforx Technology"
  }
}

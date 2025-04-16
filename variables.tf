variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
  type        = string
}

variable "app_security_group_id" {
  description = "Security Group ID of application servers that need DB access"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic to notify for RDS alarms"
  type        = string
}

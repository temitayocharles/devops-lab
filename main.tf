# ======================
# PROVIDERS CONFIGURATION
# ======================
provider "aws" {
  region  = "us-east-1"
  profile = var.aws_profile

  default_tags {
    tags = {
      Environment = "prod"
      Terraform   = "true"
    }
  }
}

provider "random" {}

# ===================
# SECURITY RESOURCES
# ===================
resource "aws_kms_key" "rds_kms" {
  description             = "RDS Encryption Key"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_security_group" "rds" {
  name_prefix = "prod-rds-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups  = [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "prod-main-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "Prod DB Subnet Group"
  }
}

# ===================
# RANDOM GENERATORS
# ===================
resource "random_password" "master" {
  length           = 32
  special          = true
  override_special = "!&*-_=+[]{}<>:?"
}

resource "random_id" "db_snapshot" {
  byte_length = 8
}

# ===================
# RDS CONFIGURATION
# ===================
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.1.0"

  # Basic Identification
  identifier = "prod-db-main"

  # Engine Configuration
  engine               = "postgres"
  engine_version       = "15.12"
  family               = "postgres15"
  instance_class       = "db.m6g.large"
  allocated_storage    = 100
  max_allocated_storage = 500
  port                 = 5432

  # Availability
  multi_az             = true

  # Credentials
  db_name              = "prod_db"
  username             = "admin_prod"
  password             = random_password.master.result

  # Security
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  publicly_accessible    = false
  kms_key_id            = aws_kms_key.rds_kms.arn
  storage_encrypted     = true

  # Backup Configuration
  backup_retention_period = 35
  backup_window           = "02:00-03:00"
  skip_final_snapshot     = false

  # Monitoring
  monitoring_interval              = 60
  monitoring_role_name             = "rds-monitoring-role"
  create_monitoring_role           = true
  performance_insights_enabled     = true
  performance_insights_retention_period = 731

  # Database Parameters
  parameters = [
    {
      name         = "shared_buffers"
      value        = "12288"
      apply_method = "pending-reboot"
    },
    {
      name         = "maintenance_work_mem"
      value        = "2048"
      apply_method = "pending-reboot"
    }
  ]

  # Ensure ManageMasterUserPassword is set to false
  manage_master_user_password = false
}


# ===================
# READ REPLICA CONFIGURATION
# ===================
resource "aws_db_instance" "read_replica" {
  identifier              = "prod-db-main-read-replica"
  replicate_source_db     = module.rds.db_instance_arn  # Change to ARN
  instance_class          = "db.m6g.large"
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  kms_key_id              = aws_kms_key.rds_kms.arn
  storage_encrypted       = true
  backup_retention_period = 7
}


# ===================
# MONITORING ALERT
# ===================
resource "aws_cloudwatch_metric_alarm" "rds_cpu_high" {
  alarm_name          = "rds-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 75
  alarm_description   = "Alarm when RDS CPU is greater than 75%"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = module.rds.db_instance_identifier
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_storage_low" {
  alarm_name          = "rds-storage-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 600
  statistic           = "Minimum"
  threshold           = 10737418240  # 10GB
  alarm_description   = "Alarm when RDS storage is below 10GB"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = module.rds.db_instance_identifier
  }
}

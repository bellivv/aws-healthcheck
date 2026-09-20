variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Name used to tag and prefix resources for this project"
  type        = string
  default     = "aws-healthcheck"
}
variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs for the app"
  type        = number
  default     = 7
}
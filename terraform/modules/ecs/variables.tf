variable "project_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "container_image" {
  description = "Full ECR image URI, including tag"
  type        = string
}

variable "container_port" {
  type    = number
  default = 8000
}

variable "task_execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "dynamodb_table_name" {
  type = string
}
variable "target_group_arn" {
  type = string
}
variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs for the app"
  type        = number
  default     = 7
}
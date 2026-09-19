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
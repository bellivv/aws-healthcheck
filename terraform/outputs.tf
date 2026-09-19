output "monitors_table_name" {
  description = "Name of the DynamoDB table storing monitors"
  value       = module.monitors_table.table_name
}

output "monitors_table_arn" {
  description = "ARN of the DynamoDB table storing monitors"
  value       = module.monitors_table.table_arn
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.networking.public_subnet_ids
}

output "alb_security_group_id" {
  description = "Security group ID for the ALB"
  value       = module.networking.alb_security_group_id
}

output "ecs_security_group_id" {
  description = "Security group ID for the ECS service"
  value       = module.networking.ecs_security_group_id
}

output "ecr_repository_url" {
  description = "URL of the ECR repository for the app image"
  value       = aws_ecr_repository.app.repository_url
}
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

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role (used by the app)"
  value       = aws_iam_role.ecs_task.arn
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "ecs_log_group_name" {
  value = module.ecs.log_group_name
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
output "results_table_name" {
  value = module.results_table.table_name
}

output "results_table_arn" {
  value = module.results_table.table_arn
}
output "checker_task_definition_arn" {
  value = module.ecs.checker_task_definition_arn
}
output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "service_name" {
  value = aws_ecs_service.app.name
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.app.name
}
output "checker_task_definition_arn" {
  value = aws_ecs_task_definition.checker.arn
}
output "cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "checker_task_definition_family_arn" {
  description = "ARN of the checker task definition family, without a revision number — resolves to whatever revision is currently ACTIVE at run time"
  value       = aws_ecs_task_definition.checker.arn_without_revision
}
output "service_arn" {
  value = aws_ecs_service.app.id
}
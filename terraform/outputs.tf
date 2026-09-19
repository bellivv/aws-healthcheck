output "monitors_table_name" {
  description = "Name of the DynamoDB table storing monitors"
  value       = module.monitors_table.table_name
}

output "monitors_table_arn" {
  description = "ARN of the DynamoDB table storing monitors"
  value       = module.monitors_table.table_arn
}
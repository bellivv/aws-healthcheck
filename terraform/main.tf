module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name
}

module "monitors_table" {
  source       = "./modules/dynamodb"
  table_name   = "${var.project_name}-monitors"
  project_name = var.project_name
}

module "ecs" {
  source                   = "./modules/ecs"
  project_name             = var.project_name
  aws_region                = var.aws_region
  container_image           = "${aws_ecr_repository.app.repository_url}:v1"
  task_execution_role_arn   = aws_iam_role.ecs_task_execution.arn
  task_role_arn             = aws_iam_role.ecs_task.arn
  subnet_ids                = module.networking.public_subnet_ids
  security_group_id         = module.networking.ecs_security_group_id
  dynamodb_table_name       = module.monitors_table.table_name
}
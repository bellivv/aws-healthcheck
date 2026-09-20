module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name
}

module "monitors_table" {
  source       = "./modules/dynamodb"
  table_name   = "${var.project_name}-monitors"
  project_name = var.project_name
}

module "results_table" {
  source         = "./modules/dynamodb"
  table_name     = "${var.project_name}-results"
  project_name   = var.project_name
  hash_key_name  = "monitor_id"
  range_key_name = "checked_at"
}

module "alb" {
  source             = "./modules/alb"
  project_name       = var.project_name
  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.public_subnet_ids
  security_group_id  = module.networking.alb_security_group_id
  container_port     = 8000
}

module "ecs" {
  source                  = "./modules/ecs"
  project_name            = var.project_name
  aws_region              = var.aws_region
  container_image         = "${aws_ecr_repository.app.repository_url}:v2"
  task_execution_role_arn = aws_iam_role.ecs_task_execution.arn
  task_role_arn           = aws_iam_role.ecs_task.arn
  subnet_ids              = module.networking.public_subnet_ids
  security_group_id       = module.networking.ecs_security_group_id
  dynamodb_table_name     = module.monitors_table.table_name
  target_group_arn       = module.alb.target_group_arn
    log_retention_days = var.log_retention_days
      results_table_name = module.results_table.table_name

  depends_on = [module.alb]
}


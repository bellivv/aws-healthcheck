module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name
}

module "monitors_table" {
  source       = "./modules/dynamodb"
  table_name   = "${var.project_name}-monitors"
  project_name = var.project_name
}

resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key_name
  range_key    = var.range_key_name

  attribute {
    name = var.hash_key_name
    type = "S"
  }

  dynamic "attribute" {
    for_each = var.range_key_name == null ? [] : [var.range_key_name]
    content {
      name = attribute.value
      type = "S"
    }
  }

  tags = {
    Project = var.project_name
  }
}
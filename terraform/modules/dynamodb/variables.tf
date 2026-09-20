variable "table_name" {
  description = "Name of the DynamoDB table to create"
  type        = string
}

variable "project_name" {
  description = "Project name, used for tagging"
  type        = string
}
variable "hash_key_name" {
  description = "Name of the partition key attribute"
  type        = string
  default     = "id"
}

variable "range_key_name" {
  description = "Name of the sort key attribute (optional). Leave unset for a partition-key-only table."
  type        = string
  default     = null
}
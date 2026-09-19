variable "project_name" {
  description = "Project name, used for tagging and naming resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the two public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "Two Availability Zones to spread the public subnets across"
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b"]
}
variable "db_name" {
  type        = string
  default     = "db_default_name"
  description = "MYSQL db name"
}

variable "db_username" {
  type        = string
  default     = "Anton"
  description = "MySQL username"
}

variable "cluster_id" {
  type = string
}

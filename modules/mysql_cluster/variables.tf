variable "cluster_name" {
  type        = string
  default     = "cluster_default_name"
  description = "MYSQL cluster name"
}

variable "network_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "HA" {
  type = bool
}

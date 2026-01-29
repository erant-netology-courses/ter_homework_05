variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "subnets" {
  type = list(object({
    zone = string
    v4_cidr_blocks = set(string)
  }))
  description = "List of subnets"
}
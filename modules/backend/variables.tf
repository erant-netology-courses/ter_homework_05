# variable "folder_id" {
#   type        = string
#   description = "Yandex Cloud folder ID where resources will be created"
# }

variable "bucket_name" {
  type        = string
  description = "Globally unique name for the S3 bucket (will hold tfstate)"
}

variable "service_account_name" {
  type        = string
  default     = "terraform-state-sa"
  description = "Name for the service account"
}
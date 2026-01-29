output "bucket_name" {
  description = "Name of the created S3 bucket for tfstate"
  value       = yandex_storage_bucket.tf_state.bucket
}

output "access_key_id" {
  description = "Access Key ID for the service account (sensitive)"
  value       = yandex_iam_service_account_static_access_key.tf_state_key.access_key
  sensitive   = true
}

output "secret_key" {
  description = "Secret Key for the service account (sensitive)"
  value       = yandex_iam_service_account_static_access_key.tf_state_key.secret_key
  sensitive   = true
}

output "backend_config_example" {
  description = "Example backend configuration to use in other projects"
  value = <<-EOT
    # Paste this into your other project's backend.tf
    terraform {
      backend "s3" {
        endpoint   = "storage.yandexcloud.net"
        bucket     = "${yandex_storage_bucket.tf_state.bucket}"
        region     = "ru-central1"
        key        = "terraform.tfstate" # Or your project-specific path

        access_key = "${yandex_iam_service_account_static_access_key.tf_state_key.access_key}"
        secret_key = "${yandex_iam_service_account_static_access_key.tf_state_key.secret_key}"

        skip_region_validation      = true
        skip_credentials_validation = true
        skip_requesting_account_id  = true
        # For Terraform >= 1.6, consider: use_lockfile = true
      }
    }
  EOT
  sensitive   = true
}
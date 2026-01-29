terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  # token                    = "do not use!!!"
  cloud_id                 = "b1ghf04gk3pjrsrgql70"
  folder_id                = "b1gk2qqtnghqup9askeq"
  service_account_key_file = file("../../../authkey.json")
  zone                     = "ru-central1-a" #(Optional)
}

data "yandex_client_config" "client" {}

resource "yandex_iam_service_account" "tf_state" {
  folder_id = data.yandex_client_config.client.folder_id
  name      = var.service_account_name
  description = "Service account for managing Terraform remote state"
}

resource "yandex_resourcemanager_folder_iam_member" "tf_state_storage_editor" {
  folder_id = data.yandex_client_config.client.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.tf_state.id}"
}

resource "yandex_iam_service_account_static_access_key" "tf_state_key" {
  service_account_id = yandex_iam_service_account.tf_state.id
  description        = "Static access key for Terraform state bucket"
}

resource "yandex_storage_bucket" "tf_state" {
  bucket = var.bucket_name

  access_key = yandex_iam_service_account_static_access_key.tf_state_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.tf_state_key.secret_key

  versioning {
    enabled = true
  }

  force_destroy = false
}
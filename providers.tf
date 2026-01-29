terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }


  backend "s3" {
    bucket  = "terraform-state-erant"
    key     = "terraform.tfstate"
    region  = "ru-central1"

    # Встроенный механизм блокировок (Terraform >= 1.6)
    # Не требует отдельной базы данных!
    use_lockfile = true

    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }

  required_version = "~>1.12.0"
}

provider "yandex" {
  # token                    = "do not use!!!"
  cloud_id                 = "b1ghf04gk3pjrsrgql70"
  folder_id                = "b1gk2qqtnghqup9askeq"
  service_account_key_file = file("../authkey.json")
  zone                     = "ru-central1-a" #(Optional)
}

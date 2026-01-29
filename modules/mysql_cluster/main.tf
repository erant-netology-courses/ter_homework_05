terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4"
}

resource "yandex_mdb_mysql_cluster" "my-module-mysql-cluster" {
  name           = var.cluster_name
  network_id     = var.network_id
  environment = "PRODUCTION"
  version     = "8.0"

  dynamic "host" {
    for_each = range(var.HA ? 1 : 4)

    content {
      zone      = var.zone
      subnet_id = var.subnet_id
    }
  }

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 20
  }
}

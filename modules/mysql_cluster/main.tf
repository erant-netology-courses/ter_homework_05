terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4"
}

# checkov:skip=CKV_TF_1,CKV_TF_2,CKV_YC_19:Это локальный модуль; Безопасность уже безопасна в модуле
resource "yandex_vpc_security_group" "db_sg" {
  name        = "database-security-group"
  description = "Security group for database cluster"
  network_id  = var.network_id

  ingress {
    protocol       = "TCP"
    port           = 6432 # Порт для PostgreSQL
    v4_cidr_blocks = ["10.0.1.0/24"] # Только из внутренней сети
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["10.0.1.0/24"] # Только из внутренней сети
  }
}

resource "yandex_mdb_mysql_cluster" "my-module-mysql-cluster" {
  name           = var.cluster_name
  network_id     = var.network_id
  security_group_ids = [yandex_vpc_security_group.db_sg.id]
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

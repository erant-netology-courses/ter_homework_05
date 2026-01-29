terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4"
}

resource "yandex_mdb_mysql_user" "my-module-mysql-user" {
  cluster_id = var.cluster_id
  name       = var.db_username
  password   = "anton_Pa$$word123"

  permission {
    database_name = yandex_mdb_mysql_database.my-module-mysql-db.name
    roles         = ["ALL"]
  }

  permission {
    database_name = yandex_mdb_mysql_database.my-module-mysql-db.name
    roles         = ["ALL", "INSERT"]
  }

  connection_limits {
    max_questions_per_hour   = 10
    max_updates_per_hour     = 20
    max_connections_per_hour = 30
    max_user_connections     = 40
  }

  global_permissions = ["PROCESS"]

  authentication_plugin = "SHA256_PASSWORD"
}

resource "yandex_mdb_mysql_database" "my-module-mysql-db" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

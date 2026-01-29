output "user" {
  value = yandex_mdb_mysql_user.my-module-mysql-user
  description = "MySQL user"
}

output "database" {
  value = yandex_mdb_mysql_database.my-module-mysql-db
  description = "MySQL DB"
}

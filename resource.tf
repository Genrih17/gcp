resource "random_id" "db-name-suffix" {
  byte_length            = 4
}

resource "random_password" "password" {
  length                 = 16
}

resource "google_sql_database_instance" "instance" {
  name                   = "private-instance-${random_id.db-name-suffix.hex}"
  region                 = var.region
  database_version       = "MYSQL_8_0"
  settings {
    tier                 = "db-f1-micro"
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
    availability_type    = "REGIONAL"
    ip_configuration {
      ipv4_enabled       = false
      private_network    = "projects/arcane-shape-319007/global/networks/default"
    }
  }
}

resource "google_sql_database" "database" {
  name                   = "my-database"
  instance               = google_sql_database_instance.instance.name
}

resource "google_sql_user" "users" {
  name                   = var.username
  password               = random_password.password.result
  instance               = google_sql_database_instance.instance.name
}

provider "postgresql" {
  host            = var.database_host
  port            = var.database_port
  username        = var.database_username
  password        = var.database_password
  superuser       = false
  max_connections = 0
}

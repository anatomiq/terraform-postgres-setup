provider "aws" {
  region = var.aws_region
  default_tags {
    tags = local.tags
  }
}

provider "postgresql" {
  host            = var.database_host
  port            = 5342
  username        = var.database_username
  password        = var.database_password
  superuser       = false
  max_connections = 0
}

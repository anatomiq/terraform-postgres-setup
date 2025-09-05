module "postgres_setup" {
  source = "../"

  database             = var.database
  users                = var.users
  passwords_parameters = var.passwords_parameters
}

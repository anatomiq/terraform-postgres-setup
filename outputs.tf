output "role_passwords" {
  description = "The passwords for each role"
  value = {
    for role_name, role_data in random_password.passwords : role_name => role_data.result
  }
  sensitive = true
}

output "role_databases" {
  description = "Databases list per role"
  value = {
    for role_name, role_data in var.roles : role_name => role_data.database_access
  }
}

output "user_passwords" {
  description = "The passwords for each user/role"
  value = {
    for user_name, user_data in random_password.passwords : user_name => user_data.result
  }
  sensitive = true
}

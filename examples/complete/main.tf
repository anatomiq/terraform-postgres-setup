module "postgres_setup" {
  source = "../../"

  passwords_parameters = {
    length  = 21
    special = false
  }

  databases = {
    adventure = {}
    journey   = {}
  }

  roles = {
    "bill" = {
      database_access               = ["adventure"]
      grant_privileges_on_database  = ["CONNECT", "CREATE"]
      grant_privileges_on_schema    = ["USAGE", "CREATE"]
      grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
      grant_privileges_on_sequences = ["USAGE", "SELECT"]
    }
    "ted" = {
      database_access               = ["adventure", "journey"]
      grant_privileges_on_database  = ["CONNECT", "CREATE"]
      grant_privileges_on_schema    = ["USAGE", "CREATE"]
      grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
      grant_privileges_on_sequences = ["USAGE", "SELECT"]
      password_length               = 16
      password_special              = true
    }
  }
}

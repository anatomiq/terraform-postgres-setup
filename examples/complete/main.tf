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

  extensions = {
    "uuid-ossp" = {
      databases = ["adventure"]
    }
    "pgcrypto" = {
      databases      = ["journey"]
      schema         = "public"
      create_cascade = true
    }
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
      foreign_data_wrapper_access   = ["postgres_fdw"]
    }
  }

  set_default_privileges = {
    "adventure" = {
      schema             = "public"
      objects_owner_user = "bill"
      roles = {
        bill = {
          default_privileges_on_tables    = ["SELECT"]
          default_privileges_on_sequences = ["USAGE", "SELECT"]
        }
        tedd = {
          default_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE"]
          default_privileges_on_sequences = ["USAGE", "SELECT"]
        }
      }
    }
  }
}

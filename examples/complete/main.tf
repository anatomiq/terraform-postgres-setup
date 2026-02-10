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
      databases = {
        "adventure" = "public"
      }
    }
    "pgcrypto" = {
      databases = {
        "journey" = "public"
      }
      create_cascade = true
    }
  }

  set_default_privileges = {
    "adventure" = {
      objects_owner_user = "bill"
      roles = {
        bill = {
          default_privileges_on_tables = ["SELECT"]
        }
        tedd = {
          schemas                      = ["public", "custom"]
          default_privileges_on_tables = ["SELECT", "INSERT", "UPDATE", "DELETE"]
        }
      }
    }
  }

  roles = {
    "bill" = {
      database_access = {
        "adventure" = ["public"]
      }
      grant_privileges_on_database  = ["CONNECT", "CREATE"]
      grant_privileges_on_schema    = ["USAGE", "CREATE"]
      grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
      grant_privileges_on_sequences = ["USAGE", "SELECT"]
    }
    "ted" = {
      database_access = {
        "adventure" = ["public"]
        "journey"   = ["public"]
      }
      grant_privileges_on_database  = ["CONNECT", "CREATE"]
      grant_privileges_on_schema    = ["USAGE", "CREATE"]
      grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
      grant_privileges_on_sequences = ["USAGE", "SELECT"]
      foreign_data_wrapper_access   = ["postgres_fdw"]
    }
  }
}

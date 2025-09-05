variable "users" {
  description = "Set of users/roles to create"
  type = map(object({
    password                        = optional(bool, true)
    grant_roles                     = optional(list(string), [])
    grant_privileges_on_database    = list(string)
    grant_privileges_on_schema      = list(string)
    grant_privileges_on_tables      = list(string)
    tables                          = optional(list(string), [])
    grant_privileges_on_sequences   = list(string)
    sequences                       = optional(list(string), [])
    set_default_privileges          = optional(bool, false)
    default_privileges_on_tables    = optional(list(string), [])
    default_privileges_on_sequences = optional(list(string), [])
    schema                          = optional(string, "public")
    objects_owner_user              = optional(string, "postgres")
  }))
}

variable "database" {
  description = "Set of databases to create"
  type = object({
    name                   = string
    template               = optional(string, "template0")
    lc_collate             = optional(string, "en_US.UTF-8")
    connection_limit       = optional(number, -1)
    allow_connections      = optional(bool, true)
    alter_object_ownership = optional(bool, false)
  })
}

variable "passwords_parameters" {
  description = "Parameters for random passwords"
  type = object({
    length  = number
    special = bool
  })
}


################################################################################
# AWS Configuration
################################################################################
aws_region          = "eu-west-1"
aws_assume_role_arn = "arn:aws:iam::533267437010:role/gha_terraform_assume_role"
environment         = "production"

################################################################################
# Module Configuration
################################################################################
rds_identifier = "klp-production-db"

databases = {
  "n8n" = {
    database = {
      name = "n8n"
    }
    users = {
      "n8n" = {
        grant_privileges_on_database  = ["CONNECT", "CREATE"]
        grant_privileges_on_schema    = ["USAGE", "CREATE"]
        grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
        grant_privileges_on_sequences = ["USAGE", "SELECT"]
      }
    }
  },
  "kulipa" = {
    database = {
      name = "kulipa"
    }
    users = {
      "kulipa" = {
        grant_privileges_on_database  = ["CONNECT", "CREATE"]
        grant_privileges_on_schema    = ["USAGE", "CREATE"]
        grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
        grant_privileges_on_sequences = ["USAGE", "SELECT"]
      },
      "ro-kulipa" = {
        grant_privileges_on_database    = ["CONNECT"]
        grant_privileges_on_schema      = ["USAGE"]
        grant_privileges_on_tables      = ["SELECT"]
        grant_privileges_on_sequences   = ["USAGE", "SELECT"]
        set_default_privileges          = true
        default_privileges_on_tables    = ["SELECT"]
        default_privileges_on_sequences = ["USAGE", "SELECT"]
        objects_owner_user              = "kulipa"
      },
      "debezium-kulipa" = {
        grant_privileges_on_database    = ["CONNECT", "CREATE"]
        grant_privileges_on_schema      = ["USAGE", "CREATE"]
        grant_privileges_on_tables      = ["SELECT", "INSERT", "UPDATE", "DELETE"]
        grant_privileges_on_sequences   = ["USAGE", "SELECT"]
        grant_roles                     = ["kulipa", "rds_replication"]
        set_default_privileges          = true
        default_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE"]
        default_privileges_on_sequences = ["USAGE", "SELECT"]
        objects_owner_user              = "kulipa"
      }
    }
  },
  "blockchain" = {
    database = {
      name = "blockchain"
    }
    users = {
      "blockchain" = {
        grant_privileges_on_database  = ["CONNECT", "CREATE"]
        grant_privileges_on_schema    = ["USAGE", "CREATE"]
        grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
        grant_privileges_on_sequences = ["USAGE", "SELECT"]
      },
      "ro-blockchain" = {
        grant_privileges_on_database    = ["CONNECT"]
        grant_privileges_on_schema      = ["USAGE"]
        grant_privileges_on_tables      = ["SELECT"]
        grant_privileges_on_sequences   = ["USAGE", "SELECT"]
        set_default_privileges          = true
        default_privileges_on_tables    = ["SELECT"]
        default_privileges_on_sequences = ["USAGE", "SELECT"]
        objects_owner_user              = "blockchain"
      },
      "debezium-blockchain" = {
        grant_privileges_on_database    = ["CONNECT", "CREATE"]
        grant_privileges_on_schema      = ["USAGE", "CREATE"]
        grant_privileges_on_tables      = ["SELECT", "INSERT", "UPDATE", "DELETE"]
        grant_privileges_on_sequences   = ["USAGE", "SELECT"]
        grant_roles                     = ["blockchain", "rds_replication"]
        set_default_privileges          = true
        default_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE"]
        default_privileges_on_sequences = ["USAGE", "SELECT"]
        objects_owner_user              = "blockchain"
      }
    }
  },
  "card-payment" = {
    database = {
      name = "card-payment"
    }
    users = {
      "card-payment" = {
        grant_privileges_on_database  = ["CONNECT", "CREATE"]
        grant_privileges_on_schema    = ["USAGE", "CREATE"]
        grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
        grant_privileges_on_sequences = ["USAGE", "SELECT"]
      },
      "ro-card-payment" = {
        grant_privileges_on_database    = ["CONNECT"]
        grant_privileges_on_schema      = ["USAGE"]
        grant_privileges_on_tables      = ["SELECT"]
        grant_privileges_on_sequences   = ["USAGE", "SELECT"]
        set_default_privileges          = true
        default_privileges_on_tables    = ["SELECT"]
        default_privileges_on_sequences = ["USAGE", "SELECT"]
        objects_owner_user              = "card-payment"
      },
      "debezium-card-payment" = {
        grant_privileges_on_database    = ["CONNECT", "CREATE"]
        grant_privileges_on_schema      = ["USAGE", "CREATE"]
        grant_privileges_on_tables      = ["SELECT", "INSERT", "UPDATE", "DELETE"]
        grant_privileges_on_sequences   = ["USAGE", "SELECT"]
        grant_roles                     = ["card-payment", "rds_replication"]
        set_default_privileges          = true
        default_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE"]
        default_privileges_on_sequences = ["USAGE", "SELECT"]
        objects_owner_user              = "card-payment"
      }
    }
  },
  "event-exporter" = {
    database = {
      name = "event-exporter"
    }
    users = {
      "event-exporter" = {
        grant_privileges_on_database  = ["CONNECT", "CREATE"]
        grant_privileges_on_schema    = ["USAGE", "CREATE"]
        grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
        grant_privileges_on_sequences = ["USAGE", "SELECT"]
      },
      "ro-event-exporter" = {
        grant_privileges_on_database    = ["CONNECT"]
        grant_privileges_on_schema      = ["USAGE"]
        grant_privileges_on_tables      = ["SELECT"]
        grant_privileges_on_sequences   = ["USAGE", "SELECT"]
        set_default_privileges          = true
        default_privileges_on_tables    = ["SELECT"]
        default_privileges_on_sequences = ["USAGE", "SELECT"]
        objects_owner_user              = "event-exporter"
      }
    }
  },
  "pds" = {
    database = {
      name = "pds"
    }
    users = {
      "pds" = {
        grant_privileges_on_database  = ["CONNECT", "CREATE"]
        grant_privileges_on_schema    = ["USAGE", "CREATE"]
        grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
        grant_privileges_on_sequences = ["USAGE", "SELECT"]
      },
      "ro-pds" = {
        grant_privileges_on_database    = ["CONNECT"]
        grant_privileges_on_schema      = ["USAGE"]
        grant_privileges_on_tables      = ["SELECT"]
        grant_privileges_on_sequences   = ["USAGE", "SELECT"]
        set_default_privileges          = true
        default_privileges_on_tables    = ["SELECT"]
        default_privileges_on_sequences = ["USAGE", "SELECT"]
        objects_owner_user              = "pds"
      },
      "debezium-pds" = {
        grant_privileges_on_database    = ["CONNECT", "CREATE"]
        grant_privileges_on_schema      = ["USAGE", "CREATE"]
        grant_privileges_on_tables      = ["SELECT", "INSERT", "UPDATE", "DELETE"]
        grant_privileges_on_sequences   = ["USAGE", "SELECT"]
        grant_roles                     = ["pds", "rds_replication"]
        set_default_privileges          = true
        default_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE"]
        default_privileges_on_sequences = ["USAGE", "SELECT"]
        objects_owner_user              = "pds"
      }
    }
  }
}

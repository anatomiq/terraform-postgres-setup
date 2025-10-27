variable "roles" {
  description = "Set of roles to create; each can target one or more databases"
  type = map(object({
    login                         = optional(bool, true)
    password                      = optional(bool, true)
    password_version              = optional(number, 1)
    grant_roles                   = optional(list(string), [])
    database_access               = list(string)
    grant_privileges_on_database  = optional(list(string), [])
    grant_privileges_on_schema    = optional(list(string), [])
    grant_privileges_on_tables    = optional(list(string), [])
    tables                        = optional(list(string), [])
    grant_privileges_on_sequences = optional(list(string), [])
    sequences                     = optional(list(string), [])
    grant_privileges_on_fdw       = optional(list(string), [])
    foreign_data_wrapper_access   = optional(list(string), [])
    schema                        = optional(string, "public")
  }))
}

variable "databases" {
  description = "Databases to create (key is database name). If empty, no DBs are created."
  type = map(object({
    template               = optional(string, "template0")
    lc_collate             = optional(string, "en_US.UTF-8")
    connection_limit       = optional(number, -1)
    allow_connections      = optional(bool, true)
    alter_object_ownership = optional(bool, false)
  }))
  default = {}
}

variable "set_default_privileges" {
  description = "Default privileges to apply per database and schema, with per-role customization"
  type = map(object({
    schema             = optional(string, "public")
    objects_owner_user = optional(string, "postgres")
    roles = map(object({
      default_privileges_on_tables    = optional(list(string), [])
      default_privileges_on_sequences = optional(list(string), [])
      default_privileges_on_functions = optional(list(string), [])
      default_privileges_on_types     = optional(list(string), [])
      default_privileges_on_schemas   = optional(list(string), [])
    }))
  }))
  default = {}
}

variable "extensions" {
  description = "PostgreSQL extensions to create, with target databases"
  type = map(object({
    databases      = list(string)
    schema         = optional(string)
    version        = optional(string)
    drop_cascade   = optional(bool, false)
    create_cascade = optional(bool, false)
  }))
  default = {}
}

variable "passwords_parameters" {
  description = "Parameters for random passwords"
  type = object({
    length  = number
    special = bool
  })
  default = {
    length  = 21
    special = false
  }
}

variable "external_passwords" {
  description = "If true, do not generate passwords; expect provided_passwords map"
  type        = bool
  default     = false
}

variable "ephemeral_passwords" {
  description = "If true, generate ephemeral_password instead of random_password"
  type        = bool
  default     = false
}

variable "provided_passwords" {
  description = "Optional map of user => password when external_passwords is true"
  type        = map(string)
  default     = {}
}

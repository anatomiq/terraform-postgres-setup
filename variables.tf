variable "roles" {
  description = "Set of roles to create; each can target one or more databases"
  type = map(object({
    login                           = optional(bool, true)
    password                        = optional(bool, true)
    password_version                = optional(number, 1)
    password_length                 = optional(number)
    password_special                = optional(bool)
    password_override_special       = optional(string)
    grant_roles                     = optional(list(string), [])
    database_access                 = list(string)
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

variable "passwords_parameters" {
  description = "Parameters for random passwords"
  type = object({
    length           = number
    special          = bool
    override_special = optional(string)
  })
  default = {
    length  = 21
    special = true
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

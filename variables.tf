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

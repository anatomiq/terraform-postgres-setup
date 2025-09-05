variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "environment" {
  description = "The environment to deploy to"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
  default     = {}
}

variable "database_host" {
  type        = string
  description = "PostgreSQL database connection host to create resources in"
}

variable "database_port" {
  type        = string
  description = "PostgreSQL database connection port to create resources in"
  default     = 5342
}

variable "database_username" {
  type        = string
  description = "PostgreSQL database connection username to create resources in"
}

variable "database_password" {
  type        = string
  description = "PostgreSQL database connection password to create resources in"
}

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
  default = {
    "example-user" = {
      grant_privileges_on_database  = ["CONNECT", "CREATE"]
      grant_privileges_on_schema    = ["USAGE", "CREATE"]
      grant_privileges_on_tables    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
      grant_privileges_on_sequences = ["USAGE", "SELECT"]
    }
  }
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
  default = {
    name = "example-database"
  }
}

variable "passwords_parameters" {
  description = "Parameters for random passwords"
  type = object({
    length  = number
    special = bool
  })
  default = {
    length  = 21
    special = true
  }
}

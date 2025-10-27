#===============================================================
# Create PostgreSQL Databases (iterate map). If empty, no DBs are created
resource "postgresql_database" "database" {
  for_each               = var.databases
  name                   = each.key
  template               = each.value.template
  lc_collate             = each.value.lc_collate
  connection_limit       = each.value.connection_limit
  allow_connections      = each.value.allow_connections
  alter_object_ownership = each.value.alter_object_ownership
}

#===============================================================
# Create PostgreSQL Extensions per Database
resource "postgresql_extension" "extensions" {
  for_each = {
    for pair in flatten([
      for ext_name, ext_conf in var.extensions : [
        for db_name in ext_conf.databases : {
          ext_name = ext_name
          db_name  = db_name
          conf     = ext_conf
        }
      ]
    ]) : "${pair.db_name}_${pair.ext_name}" => pair
  }

  name           = each.value.ext_name
  database       = each.value.db_name
  schema         = lookup(each.value.conf, "schema", null)
  version        = lookup(each.value.conf, "version", null)
  drop_cascade   = lookup(each.value.conf, "drop_cascade", false)
  create_cascade = lookup(each.value.conf, "create_cascade", false)

  depends_on = [postgresql_database.database]
}

#===============================================================
# Generate Random Passwords for local users (unless external passwords)
resource "random_password" "passwords" {
  for_each = {
    for k, v in var.roles :
    k => v
    if lookup(v, "password", true) == true && var.external_passwords == false && var.ephemeral_passwords == false
  }

  length  = var.passwords_parameters.length
  special = var.passwords_parameters.special
}

ephemeral "random_password" "passwords" {
  for_each = {
    for k, v in var.roles :
    k => v
    if lookup(v, "password", true) == true && var.external_passwords == false
  }

  length  = var.passwords_parameters.length
  special = var.passwords_parameters.special
}

#===============================================================
# Create PostgreSQL Roles
resource "postgresql_role" "default" {
  for_each = var.roles

  name  = each.key
  login = lookup(each.value, "login", true)
  password_wo = lookup(each.value, "password", true) ? (
    var.external_passwords ? lookup(var.provided_passwords, each.key, null) : (
      var.ephemeral_passwords ? ephemeral.random_password.passwords[each.key].result : random_password.passwords[each.key].result
    )
  ) : null
  password_wo_version = lookup(each.value, "password", true) ? lookup(each.value, "password_version", 1) : null
  roles               = each.value.grant_roles
}

#===============================================================
# Grant Privileges on Database
resource "postgresql_grant" "database" {
  for_each = {
    for pair in flatten([
      for role_name, role_data in var.roles : [
        for db_name in role_data.database_access : {
          role_name = role_name
          db_name   = db_name
          data      = role_data
        }
      ]
    ]) : "${pair.role_name}_${pair.db_name}" => pair
    if length(pair.data.grant_privileges_on_database) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.data.grant_privileges_on_database
  object_type = "database"
  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

#===============================================================
# Grant Privileges on Schema
resource "postgresql_grant" "schema" {
  for_each = {
    for pair in flatten([
      for role_name, role_data in var.roles : [
        for db_name in role_data.database_access : {
          role_name = role_name
          db_name   = db_name
          data      = role_data
        }
      ]
    ]) : "${pair.role_name}_${pair.db_name}" => pair
    if length(pair.data.grant_privileges_on_schema) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.data.grant_privileges_on_schema
  object_type = "schema"
  schema      = lookup(each.value.data, "schema", "public")
  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

#===============================================================
# Grant Privileges on Tables
resource "postgresql_grant" "tables" {
  for_each = {
    for pair in flatten([
      for role_name, role_data in var.roles : [
        for db_name in role_data.database_access : {
          role_name = role_name
          db_name   = db_name
          data      = role_data
        }
      ]
    ]) : "${pair.role_name}_${pair.db_name}" => pair
    if length(pair.data.grant_privileges_on_tables) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.data.grant_privileges_on_tables
  object_type = "table"
  objects     = lookup(each.value.data, "tables", [])
  schema      = lookup(each.value.data, "schema", "public")
  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

#===============================================================
# Grant Privileges on Sequences
resource "postgresql_grant" "sequences" {
  for_each = {
    for pair in flatten([
      for role_name, role_data in var.roles : [
        for db_name in role_data.database_access : {
          role_name = role_name
          db_name   = db_name
          data      = role_data
        }
      ]
    ]) : "${pair.role_name}_${pair.db_name}" => pair
    if length(pair.data.grant_privileges_on_sequences) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.data.grant_privileges_on_sequences
  object_type = "sequence"
  objects     = lookup(each.value.data, "sequences", [])
  schema      = lookup(each.value.data, "schema", "public")
  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

#===============================================================
# Grant Privileges on FDW
resource "postgresql_grant" "fdw" {
  for_each = {
    for pair in flatten([
      for role_name, role_data in var.roles : [
        for db_name in role_data.database_access : {
          role_name = role_name
          db_name   = db_name
          data      = role_data
        }
      ]
    ]) : "${pair.role_name}_${pair.db_name}" => pair
    if length(pair.data.foreign_data_wrapper_access) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = ["USAGE"]
  object_type = "foreign_data_wrapper"
  objects     = each.value.data.foreign_data_wrapper_access
  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

#===============================================================
# Default Privileges on Tables
resource "postgresql_default_privileges" "db_tables" {
  for_each = {
    for pair in flatten([
      for db_name, db_cfg in var.set_default_privileges : [
        for role_name, role_cfg in db_cfg.roles : {
          key       = "${db_name}_${role_name}_tables"
          db_name   = db_name
          role_name = role_name
          db_cfg    = db_cfg
          role_cfg  = role_cfg
        }
      ]
    ]) : pair.key => pair
    if length(pair.role_cfg.default_privileges_on_tables) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.role_cfg.default_privileges_on_tables
  object_type = "table"
  schema      = lookup(each.value.db_cfg, "schema", "public")
  owner       = lookup(each.value.db_cfg, "objects_owner_user", "postgres")

  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

#===============================================================
# Default Privileges on Sequences
resource "postgresql_default_privileges" "db_sequences" {
  for_each = {
    for pair in flatten([
      for db_name, db_cfg in var.set_default_privileges : [
        for role_name, role_cfg in db_cfg.roles : {
          key       = "${db_name}_${role_name}_sequences"
          db_name   = db_name
          role_name = role_name
          db_cfg    = db_cfg
          role_cfg  = role_cfg
        }
      ]
    ]) : pair.key => pair
    if length(pair.role_cfg.default_privileges_on_sequences) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.role_cfg.default_privileges_on_sequences
  object_type = "sequence"
  schema      = lookup(each.value.db_cfg, "schema", "public")
  owner       = lookup(each.value.db_cfg, "objects_owner_user", "postgres")

  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

#===============================================================
# Default Privileges on Functions
resource "postgresql_default_privileges" "db_functions" {
  for_each = {
    for pair in flatten([
      for db_name, db_cfg in var.set_default_privileges : [
        for role_name, role_cfg in db_cfg.roles : {
          key       = "${db_name}_${role_name}_functions"
          db_name   = db_name
          role_name = role_name
          db_cfg    = db_cfg
          role_cfg  = role_cfg
        }
      ]
    ]) : pair.key => pair
    if length(pair.role_cfg.default_privileges_on_functions) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.role_cfg.default_privileges_on_functions
  object_type = "function"
  schema      = lookup(each.value.db_cfg, "schema", "public")
  owner       = lookup(each.value.db_cfg, "objects_owner_user", "postgres")

  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

#===============================================================
# Default Privileges on Types
resource "postgresql_default_privileges" "db_types" {
  for_each = {
    for pair in flatten([
      for db_name, db_cfg in var.set_default_privileges : [
        for role_name, role_cfg in db_cfg.roles : {
          key       = "${db_name}_${role_name}_types"
          db_name   = db_name
          role_name = role_name
          db_cfg    = db_cfg
          role_cfg  = role_cfg
        }
      ]
    ]) : pair.key => pair
    if length(pair.role_cfg.default_privileges_on_types) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.role_cfg.default_privileges_on_types
  object_type = "type"
  schema      = lookup(each.value.db_cfg, "schema", "public")
  owner       = lookup(each.value.db_cfg, "objects_owner_user", "postgres")

  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

#===============================================================
# Default Privileges on Schemas
resource "postgresql_default_privileges" "db_schemas" {
  for_each = {
    for pair in flatten([
      for db_name, db_cfg in var.set_default_privileges : [
        for role_name, role_cfg in db_cfg.roles : {
          key       = "${db_name}_${role_name}_schemas"
          db_name   = db_name
          role_name = role_name
          db_cfg    = db_cfg
          role_cfg  = role_cfg
        }
      ]
    ]) : pair.key => pair
    if length(pair.role_cfg.default_privileges_on_schemas) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.role_cfg.default_privileges_on_schemas
  object_type = "schema"
  schema      = lookup(each.value.db_cfg, "schema", "public")
  owner       = lookup(each.value.db_cfg, "objects_owner_user", "postgres")

  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

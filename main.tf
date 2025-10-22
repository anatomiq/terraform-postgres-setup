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
# Default Privileges for Tables
resource "postgresql_default_privileges" "default_tables" {
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
    if pair.data.set_default_privileges && length(pair.data.default_privileges_on_tables) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.data.default_privileges_on_tables
  object_type = "table"
  schema      = lookup(each.value.data, "schema", "public")
  owner       = each.value.data.objects_owner_user
  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

#===============================================================
# Default Privileges for Sequences
resource "postgresql_default_privileges" "default_sequences" {
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
    if pair.data.set_default_privileges && length(pair.data.default_privileges_on_sequences) > 0
  }

  database    = each.value.db_name
  role        = postgresql_role.default[each.value.role_name].name
  privileges  = each.value.data.default_privileges_on_sequences
  object_type = "sequence"
  schema      = lookup(each.value.data, "schema", "public")
  owner       = each.value.data.objects_owner_user
  depends_on = [
    postgresql_role.default,
    postgresql_database.database
  ]
}

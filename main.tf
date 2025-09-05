#===============================================================
# Create PostgreSQL Database
resource "postgresql_database" "database" {
  name                   = var.database.name
  template               = var.database.template
  lc_collate             = var.database.lc_collate
  connection_limit       = var.database.connection_limit
  allow_connections      = var.database.allow_connections
  alter_object_ownership = var.database.alter_object_ownership

  depends_on = [
    postgresql_role.default
  ]
}

#===============================================================
# Generate Random Passwords if specified
resource "random_password" "passwords" {
  for_each = { for k, v in var.users : k => v if v.password == true }
  length   = var.passwords_parameters.length
  special  = var.passwords_parameters.special
}

#===============================================================
# Create PostgreSQL Roles
resource "postgresql_role" "default" {
  for_each = var.users

  name     = each.key
  login    = lookup(each.value, "password", false) == true ? true : false
  password = lookup(each.value, "password", false) == true ? random_password.passwords[each.key].result : each.value.password
  roles    = each.value.grant_roles
}

#===============================================================
# Other resources (Grants, Default Privileges) remain the same

#===============================================================
# Grant Privileges on Database
resource "postgresql_grant" "database" {
  for_each = var.users

  database    = postgresql_database.database.name
  role        = postgresql_role.default[each.key].name
  privileges  = each.value.grant_privileges_on_database
  object_type = "database"

  depends_on = [
    postgresql_database.database,
    postgresql_role.default
  ]
}

#===============================================================
# Grant Privileges on Schema
resource "postgresql_grant" "schema" {
  for_each = var.users

  database    = postgresql_database.database.name
  role        = postgresql_role.default[each.key].name
  privileges  = each.value.grant_privileges_on_schema
  object_type = "schema"
  schema      = each.value.schema

  depends_on = [
    postgresql_database.database,
    postgresql_role.default,
    postgresql_grant.database
  ]
}

#===============================================================
# Grant Privileges on Tables
resource "postgresql_grant" "tables" {
  for_each = var.users

  database    = postgresql_database.database.name
  role        = postgresql_role.default[each.key].name
  privileges  = each.value.grant_privileges_on_tables
  object_type = "table"
  objects     = each.value.tables
  schema      = each.value.schema

  depends_on = [
    postgresql_database.database,
    postgresql_role.default,
    postgresql_grant.schema
  ]
}

#===============================================================
# Grant Privileges on Sequences
resource "postgresql_grant" "sequences" {
  for_each = var.users

  database    = postgresql_database.database.name
  role        = postgresql_role.default[each.key].name
  privileges  = each.value.grant_privileges_on_sequences
  object_type = "sequence"
  objects     = each.value.sequences
  schema      = each.value.schema

  depends_on = [
    postgresql_database.database,
    postgresql_role.default,
    postgresql_grant.tables
  ]
}

#===============================================================
# Default Privileges for Tables
resource "postgresql_default_privileges" "default_tables" {
  for_each = {
    for user_name, user_data in var.users :
    user_name => user_data
    if user_data.set_default_privileges
  }

  database    = postgresql_database.database.name
  role        = postgresql_role.default[each.key].name
  privileges  = each.value.default_privileges_on_tables
  object_type = "table"
  schema      = each.value.schema
  owner       = each.value.objects_owner_user

  depends_on = [
    postgresql_database.database,
    postgresql_role.default,
    postgresql_grant.database,
    postgresql_grant.schema,
    postgresql_grant.tables,
    postgresql_grant.sequences
  ]
}

#===============================================================
# Default Privileges for Sequences
resource "postgresql_default_privileges" "default_sequences" {
  for_each = {
    for user_name, user_data in var.users :
    user_name => user_data
    if user_data.set_default_privileges
  }

  database    = postgresql_database.database.name
  role        = postgresql_role.default[each.key].name
  privileges  = each.value.default_privileges_on_sequences
  object_type = "sequence"
  schema      = each.value.schema
  owner       = each.value.objects_owner_user

  depends_on = [
    postgresql_database.database,
    postgresql_role.default,
    postgresql_grant.database,
    postgresql_grant.schema,
    postgresql_grant.tables,
    postgresql_grant.sequences,
    postgresql_default_privileges.default_tables
  ]
}

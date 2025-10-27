# PostgreSQL Setup

Configuration in this directory creates PostgreSQL databases, roles with random passwords and its permissions.

## Usage

To use this module, you need to include it in your Terraform configuration. You can do this by adding the following to your `main.tf` file:

```hcl
module "[module_name]" {
  source = [module_version]
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
      databases       = ["journey"]
      schema          = "public"
      create_cascade  = true
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
    }
  }
}
```

To run this example execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

To destroy this example execute:

```bash
$ terraform destroy
```

## Examples

- [Complete](https://github.com/anatomiq/terraform-postgres-setup/tree/main/examples/aws)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | 1.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_postgresql"></a> [postgresql](#provider\_postgresql) | 1.26.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [postgresql_database.database](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/database) | resource |
| [postgresql_default_privileges.db_functions](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/default_privileges) | resource |
| [postgresql_default_privileges.db_schemas](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/default_privileges) | resource |
| [postgresql_default_privileges.db_sequences](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/default_privileges) | resource |
| [postgresql_default_privileges.db_tables](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/default_privileges) | resource |
| [postgresql_default_privileges.db_types](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/default_privileges) | resource |
| [postgresql_extension.extensions](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/extension) | resource |
| [postgresql_grant.database](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/grant) | resource |
| [postgresql_grant.fdw](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/grant) | resource |
| [postgresql_grant.schema](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/grant) | resource |
| [postgresql_grant.sequences](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/grant) | resource |
| [postgresql_grant.tables](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/grant) | resource |
| [postgresql_role.default](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/role) | resource |
| [random_password.passwords](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databases"></a> [databases](#input\_databases) | Databases to create (key is database name). If empty, no DBs are created. | <pre>map(object({<br/>    template               = optional(string, "template0")<br/>    lc_collate             = optional(string, "en_US.UTF-8")<br/>    connection_limit       = optional(number, -1)<br/>    allow_connections      = optional(bool, true)<br/>    alter_object_ownership = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_ephemeral_passwords"></a> [ephemeral\_passwords](#input\_ephemeral\_passwords) | If true, generate ephemeral\_password instead of random\_password | `bool` | `false` | no |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | PostgreSQL extensions to create, with target databases | <pre>map(object({<br/>    databases      = list(string)<br/>    schema         = optional(string)<br/>    version        = optional(string)<br/>    drop_cascade   = optional(bool, false)<br/>    create_cascade = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_external_passwords"></a> [external\_passwords](#input\_external\_passwords) | If true, do not generate passwords; expect provided\_passwords map | `bool` | `false` | no |
| <a name="input_passwords_parameters"></a> [passwords\_parameters](#input\_passwords\_parameters) | Parameters for random passwords | <pre>object({<br/>    length  = number<br/>    special = bool<br/>  })</pre> | <pre>{<br/>  "length": 21,<br/>  "special": false<br/>}</pre> | no |
| <a name="input_provided_passwords"></a> [provided\_passwords](#input\_provided\_passwords) | Optional map of user => password when external\_passwords is true | `map(string)` | `{}` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Set of roles to create; each can target one or more databases | <pre>map(object({<br/>    login                         = optional(bool, true)<br/>    password                      = optional(bool, true)<br/>    password_version              = optional(number, 1)<br/>    grant_roles                   = optional(list(string), [])<br/>    database_access               = list(string)<br/>    grant_privileges_on_database  = optional(list(string), [])<br/>    grant_privileges_on_schema    = optional(list(string), [])<br/>    grant_privileges_on_tables    = optional(list(string), [])<br/>    tables                        = optional(list(string), [])<br/>    grant_privileges_on_sequences = optional(list(string), [])<br/>    sequences                     = optional(list(string), [])<br/>    grant_privileges_on_fdw       = optional(list(string), [])<br/>    foreign_data_wrapper_access   = optional(list(string), [])<br/>    schema                        = optional(string, "public")<br/>  }))</pre> | n/a | yes |
| <a name="input_set_default_privileges"></a> [set\_default\_privileges](#input\_set\_default\_privileges) | Default privileges to apply per database and schema, with per-role customization | <pre>map(object({<br/>    schema             = optional(string, "public")<br/>    objects_owner_user = optional(string, "postgres")<br/>    roles = map(object({<br/>      default_privileges_on_tables    = optional(list(string), [])<br/>      default_privileges_on_sequences = optional(list(string), [])<br/>      default_privileges_on_functions = optional(list(string), [])<br/>      default_privileges_on_types     = optional(list(string), [])<br/>      default_privileges_on_schemas   = optional(list(string), [])<br/>    }))<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_databases"></a> [role\_databases](#output\_role\_databases) | Databases list per role |
| <a name="output_role_passwords"></a> [role\_passwords](#output\_role\_passwords) | The passwords for each role |
<!-- END_TF_DOCS -->

## License
Apache 2 Licensed. See [LICENSE](https://github.com/anatomiq/terraform-postgres-setup/blob/main/LICENSE) for full details.

# PostgreSQL Setup

Configuration in this directory creates PostgreSQL databases, roles with random passwords and its permissions.

## Usage

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

# Creating a Release Tag for the Terraform Module

To create a versioned release and push it to GitHub:

```bash
# 1. Make sure all changes are committed
git add .
git commit -m "feat: initial implementation of module"

# 2. Create a version tag (e.g., v1.0.0)
git tag -a v1.0.0 -m "Initial stable release"

# 3. Push the tag to GitHub
git push origin v1.0.0

# 4. Create a GitHub release for the tag (optional, via CLI)
gh release create v1.0.0 \
  --title "v1.0.0" \
  --notes "Initial stable release of the Terraform module"
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.12.2 |
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
| [postgresql_default_privileges.default_sequences](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/default_privileges) | resource |
| [postgresql_default_privileges.default_tables](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/default_privileges) | resource |
| [postgresql_grant.database](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.26.0/docs/resources/grant) | resource |
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
| <a name="input_external_passwords"></a> [external\_passwords](#input\_external\_passwords) | If true, do not generate passwords; expect provided\_passwords map | `bool` | `false` | no |
| <a name="input_passwords_parameters"></a> [passwords\_parameters](#input\_passwords\_parameters) | Parameters for random passwords | <pre>object({<br/>    length  = number<br/>    special = bool<br/>  })</pre> | <pre>{<br/>  "length": 21,<br/>  "special": true<br/>}</pre> | no |
| <a name="input_provided_passwords"></a> [provided\_passwords](#input\_provided\_passwords) | Optional map of user => password when external\_passwords is true | `map(string)` | `{}` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Set of roles to create; each can target one or more databases | <pre>map(object({<br/>    login                           = optional(bool, true)<br/>    password                        = optional(bool, true)<br/>    password_version                = optional(number, 1)<br/>    grant_roles                     = optional(list(string), [])<br/>    database_access                 = list(string)<br/>    grant_privileges_on_database    = list(string)<br/>    grant_privileges_on_schema      = list(string)<br/>    grant_privileges_on_tables      = list(string)<br/>    tables                          = optional(list(string), [])<br/>    grant_privileges_on_sequences   = list(string)<br/>    sequences                       = optional(list(string), [])<br/>    set_default_privileges          = optional(bool, false)<br/>    default_privileges_on_tables    = optional(list(string), [])<br/>    default_privileges_on_sequences = optional(list(string), [])<br/>    schema                          = optional(string, "public")<br/>    objects_owner_user              = optional(string, "postgres")<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_databases"></a> [role\_databases](#output\_role\_databases) | Databases list per role |
| <a name="output_role_passwords"></a> [role\_passwords](#output\_role\_passwords) | The passwords for each role |
<!-- END_TF_DOCS -->

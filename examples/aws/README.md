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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.12.2 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | 1.26.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postgres_setup"></a> [postgres\_setup](#module\_postgres\_setup) | ../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to deploy to | `string` | n/a | yes |
| <a name="input_database"></a> [database](#input\_database) | Set of databases to create | <pre>object({<br/>    name                   = string<br/>    template               = optional(string, "template0")<br/>    lc_collate             = optional(string, "en_US.UTF-8")<br/>    connection_limit       = optional(number, -1)<br/>    allow_connections      = optional(bool, true)<br/>    alter_object_ownership = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "name": "example-database"<br/>}</pre> | no |
| <a name="input_database_host"></a> [database\_host](#input\_database\_host) | PostgreSQL database connection host to create resources in | `string` | n/a | yes |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | PostgreSQL database connection password to create resources in | `string` | n/a | yes |
| <a name="input_database_port"></a> [database\_port](#input\_database\_port) | PostgreSQL database connection port to create resources in | `string` | `5342` | no |
| <a name="input_database_username"></a> [database\_username](#input\_database\_username) | PostgreSQL database connection username to create resources in | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to deploy to | `string` | n/a | yes |
| <a name="input_passwords_parameters"></a> [passwords\_parameters](#input\_passwords\_parameters) | Parameters for random passwords | <pre>object({<br/>    length  = number<br/>    special = bool<br/>  })</pre> | <pre>{<br/>  "length": 21,<br/>  "special": true<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_users"></a> [users](#input\_users) | Set of users/roles to create | <pre>map(object({<br/>    login                           = optional(bool, true)<br/>    password                        = optional(bool, true)<br/>    password_version                = optional(number, 1)<br/>    grant_roles                     = optional(list(string), [])<br/>    grant_privileges_on_database    = list(string)<br/>    grant_privileges_on_schema      = list(string)<br/>    grant_privileges_on_tables      = list(string)<br/>    tables                          = optional(list(string), [])<br/>    grant_privileges_on_sequences   = list(string)<br/>    sequences                       = optional(list(string), [])<br/>    set_default_privileges          = optional(bool, false)<br/>    default_privileges_on_tables    = optional(list(string), [])<br/>    default_privileges_on_sequences = optional(list(string), [])<br/>    schema                          = optional(string, "public")<br/>    objects_owner_user              = optional(string, "postgres")<br/>  }))</pre> | <pre>{<br/>  "example-user": {<br/>    "grant_privileges_on_database": [<br/>      "CONNECT",<br/>      "CREATE"<br/>    ],<br/>    "grant_privileges_on_schema": [<br/>      "USAGE",<br/>      "CREATE"<br/>    ],<br/>    "grant_privileges_on_sequences": [<br/>      "USAGE",<br/>      "SELECT"<br/>    ],<br/>    "grant_privileges_on_tables": [<br/>      "SELECT",<br/>      "INSERT",<br/>      "UPDATE",<br/>      "DELETE",<br/>      "TRUNCATE",<br/>      "REFERENCES",<br/>      "TRIGGER"<br/>    ]<br/>  }<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

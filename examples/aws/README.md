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
| <a name="module_postgres_setup"></a> [postgres\_setup](#module\_postgres\_setup) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_host"></a> [database\_host](#input\_database\_host) | PostgreSQL database connection host to create resources in | `string` | n/a | yes |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | PostgreSQL database connection password to create resources in | `string` | n/a | yes |
| <a name="input_database_port"></a> [database\_port](#input\_database\_port) | PostgreSQL database connection port to create resources in | `string` | `5342` | no |
| <a name="input_database_username"></a> [database\_username](#input\_database\_username) | PostgreSQL database connection username to create resources in | `string` | n/a | yes |
| <a name="input_passwords_parameters"></a> [passwords\_parameters](#input\_passwords\_parameters) | Parameters for random passwords | <pre>object({<br/>    length  = number<br/>    special = bool<br/>  })</pre> | <pre>{<br/>  "length": 21,<br/>  "special": false<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

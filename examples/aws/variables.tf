variable "database_host" {
  description = "PostgreSQL database connection host to create resources in"
  type        = string
}

variable "database_port" {
  description = "PostgreSQL database connection port to create resources in"
  type        = string
  default     = 5342
}

variable "database_username" {
  description = "PostgreSQL database connection username to create resources in"
  type        = string
}

variable "database_password" {
  description = "PostgreSQL database connection password to create resources in"
  type        = string
}

variable "passwords_parameters" {
  description = "Parameters for random passwords"
  type = object({
    length  = number
    special = bool
  })
  default = {
    length  = 21
    special = false
  }
}

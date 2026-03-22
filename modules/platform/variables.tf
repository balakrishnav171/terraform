variable "name_prefix" {
  type = string
}

variable "resource_suffix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_prefix" {
  type = string
}

variable "function_app_python_version" {
  type = string
}

variable "sql_admin_username" {
  type = string
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}

variable "sql_database_sku" {
  type = string
}

variable "github_profile_url" {
  type = string
}

variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

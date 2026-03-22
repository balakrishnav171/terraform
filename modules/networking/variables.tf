variable "name_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_address_space" {
  type = string
}

variable "vm_subnet_cidr" {
  type = string
}

variable "allowed_ssh_cidr" {
  type = string
}

variable "tags" {
  type = map(string)
}

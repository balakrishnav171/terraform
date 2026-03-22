variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "vm_admin_username" {
  type = string
}

variable "vm_admin_ssh_public_key" {
  type = string
}

variable "public_ip_name" {
  type = string
}

variable "network_interface_name" {
  type = string
}

variable "virtual_machine_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

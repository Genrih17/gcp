variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "image"{
    type = string
}

variable "type"{
    type = string
}

variable "disk_size" {}
variable "disk_type" {
  type = string
}
variable "labels" {}
variable "vm_timeout_delete" {}
variable "startup_script"{}
variable "delete_protection" {}

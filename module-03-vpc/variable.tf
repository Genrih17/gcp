variable "labels" {}
variable "vm_timeout_delete" {}
variable "startup_script"{}
variable "delete_protection" {}
variable "student_name" {}
variable "student_IDnum"{}
variable "disk_size" {}

variable "disk_type" {
  type = string
}

variable "image"{
    type = string
}

variable "type"{
    type = string
}

variable "vm_name"{
    type = string
}

variable "project"{
    type = string
}
   
variable "region"{
    type = string
    default = "us-cenral1"
}

variable "zone"{
    type = string
    default = "us-central1-c"
}

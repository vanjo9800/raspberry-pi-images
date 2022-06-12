variable "user_home_dir" {
    type    = string
    default = "/home/pi"
}

variable "pi_password_hash" {
    type = string
}

variable "ssh_authorized_key" {
    type = string
}

variable "wifi_name" {
    type = list(string)
}

variable "wifi_password" {
    type = list(string)
    sensitive = true
}

variable "version" {
    type = string
}

locals {
}

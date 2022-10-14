variable "my_azs"  {
    type = list(string)
}

variable "CIDR" {
    type = string
}

variable "private_subnets" {
    type = list(string)
}

variable "public_subnets" {
    type = list(string)
}


variable "database_subnets" {
    type = list(string)
}

variable "name" {
    type = string
}

# EC2 variable

variable "key_name" {
    type = string
}

variable "instance_type" {
    type = string
}

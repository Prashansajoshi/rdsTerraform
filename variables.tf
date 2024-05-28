variable ami {
    description = "default ami"
    default = "	ami-06d38e519dc8ebc68"
}

variable "instance_type" {
  description = "instance type"
  default = "t2.micro"
}

variable "key_name" {
    description = "default keypair"
    default = "prashansa-key"
}

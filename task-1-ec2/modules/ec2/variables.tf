variable "ami_id" {
  type = string
}

variable "instances" {
  type = map(object({
    instance_type          = string
    root_block_device_type = string
    root_block_size        = number
    iops                   = optional(number)
    key_name               = string
    environment            = string
    owner                  = string
  }))
}
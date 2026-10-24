variable "ami_id" {
  description = "The AMI ID to use for all EC2 instances."
  type        = string
}

variable "instances" {
  description = "Map of all 5 EC2 instance configurations driven by a single input variable."
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
###NAT vars

variable "vm_nat_name" {
  type        = string
  default     = "networking_lab_vm_nat"
}

variable "vm_nat_platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "vm_nat_image_id" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
}

variable "vm_nat_cores" {
  type        = number
  default     = 2
}

variable "vm_nat_memory" {
  type        = number
  default     = 1
}

variable "vm_nat_core_fraction" {
  type        = number
  default     = 20
}

variable "vm_nat_preemptible" {
  type        = bool
  default     = true
}

variable "vm_nat_ip_address" {
  type        = string
  default     = "192.168.10.254"
}

variable "vm_nat_serial_port_enable" {
  type        = number
  default     = 1
}

###VM public subnet vars

variable "vm_public_platform_name" {
  type        = string
  default     = "networking_lab_vm_public"
}

variable "vm_public_platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "vm_public_cores" {
  type        = number
  default     = 2
}

variable "vm_public_memory" {
  type        = number
  default     = 1
}

variable "vm_public_core_fraction" {
  type        = number
  default     = 20
}

variable "vm_public_preemptible" {
  type        = bool
  default     = true
}

variable "vm_public_serial_port_enable" {
  type        = number
  default     = 1
}


###VM private subnet vars

variable "vm_private_platform_name" {
  type        = string
  default     = "networking_lab_vm_private"
}

variable "vm_private_platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "vm_private_cores" {
  type        = number
  default     = 2
}

variable "vm_private_memory" {
  type        = number
  default     = 1
}

variable "vm_private_core_fraction" {
  type        = number
  default     = 20
}

variable "vm_private_preemptible" {
  type        = bool
  default     = true
}

variable "vm_private_serial_port_enable" {
  type        = number
  default     = 1
}


## common vars

variable "vm_os_family" {
  type        = string
  default     = "ubuntu-2404-lts"
}
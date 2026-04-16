############## Common vars ################
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_net_name" {
  type        = string
  default     = "lab-network"
  description = "VPC network name"
}

variable "vpc_public_subnet_name" {
  type        = string
  default     = "public"
  description = "VPC public subnet name"
}

############# Storage variables #################

variable "lab_bucket_name" {
  type        = string
  default     = "jiens-bucket-15042026"
  description = "backet name"
}

variable "lab_bucket_size" {
  type        = number
  default     = 10485760
  description = "backet max size"
}

variable "bucket_object_name" {
  type        = string
  default     = "nature.jpg"
  description = "uploaded object name"
}

variable "bucket_object_path" {
  type        = string
  default     = "./nature.jpg"
  description = "path to a file that will be read and uploaded"
}

############### Instance group variables ####################

variable "ig_name" {
  type        = string
  default     = "lamp-group"
  description = "Name of the instance group"
}

variable "ig_service_account_id" {
  type        = string
  description = "Service account ID for instance group"
  sensitive   = true
}

variable "ig_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform ID for instances"
}

variable "ig_memory" {
  type        = number
  default     = 2
  description = "Memory for each instance"
}

variable "ig_cores" {
  type        = number
  default     = 2
  description = "Number of CPU cores for each instance"
}

variable "ig_image_id" {
  type        = string
  default     = "fd827b91d99psvq5fjit"
  description = "LAMP image ID"
}

variable "ig_disk_size" {
  type        = number
  default     = 4
  description = "Boot disk size in GB"
}

variable "ig_ssh_user" {
  type        = string
  default     = "ubuntu"
  description = "SSH user for instances"
}

variable "ig_serial_port_enable" {
  type        = number
  default     = 1
  description = "Enable serial port access"
}

variable "ig_ssh_key_path" {
  type        = string
  default     = "~/.ssh/id_ed25519_yd.pub"
  description = "Path to SSH public key"
}

variable "ig_scale_size" {
  type        = number
  default     = 3
  description = "Fixed number of instances in the group"
}

variable "ig_zones" {
  type        = list(string)
  default     = ["ru-central1-a"]
  description = "Availability zones for instances"
}

variable "ig_max_unavailable" {
  type        = number
  default     = 2
  description = "Max unavailable instances during deployment"
}

variable "ig_max_creating" {
  type        = number
  default     = 2
  description = "Max creating instances during deployment"
}

variable "ig_max_expansion" {
  type        = number
  default     = 2
  description = "Max expansion instances during deployment"
}

variable "ig_max_deleting" {
  type        = number
  default     = 2
  description = "Max deleting instances during deployment"
}

# Health check variables
variable "ig_health_check_healthy_threshold" {
  type        = number
  default     = 2
  description = "Number of successful health checks before instance is healthy"
}

variable "ig_health_check_unhealthy_threshold" {
  type        = number
  default     = 2
  description = "Number of failed health checks before instance is unhealthy"
}

variable "ig_health_check_interval" {
  type        = number
  default     = 30
  description = "Interval between health checks in seconds"
}

variable "ig_health_check_timeout" {
  type        = number
  default     = 10
  description = "Health check timeout in seconds"
}

variable "ig_health_check_port" {
  type        = number
  default     = 80
  description = "Port for health checks"
}

variable "ig_health_check_path" {
  type        = string
  default     = "/"
  description = "Path for health checks"
}

variable "ig_target_group_name" {
  type        = string
  default     = "lamp-group-tg"
  description = "Target group name for load balancer"
}

############## NLB Variables ######################

variable "nlb_name" {
  type        = string
  default     = "my-network-load-balancer"
  description = "Network Load Balancer name"
}

variable "nlb_listener_name" {
  type        = string
  default     = "my-listener"
  description = "Listener name"
}

variable "nlb_listener_port" {
  type        = number
  default     = 80
  description = "Listener port"
}

variable "nlb_listener_target_port" {
  type        = number
  default     = 80
  description = "Target port for the listener"
}

variable "nlb_ip_version" {
  type        = string
  default     = "ipv4"
  description = "IP version for external address"
}

variable "nlb_healthcheck_name" {
  type        = string
  default     = "http"
  description = "Health check name"
}

variable "nlb_healthcheck_healthy_threshold" {
  type        = number
  default     = 2
  description = "Number of successful health checks before target is healthy"
}

variable "nlb_healthcheck_unhealthy_threshold" {
  type        = number
  default     = 2
  description = "Number of failed health checks before target is unhealthy"
}

variable "nlb_healthcheck_interval" {
  type        = number
  default     = 30
  description = "Interval between health checks in seconds"
}

variable "nlb_healthcheck_timeout" {
  type        = number
  default     = 10
  description = "Health check timeout in seconds"
}

variable "nlb_healthcheck_port" {
  type        = number
  default     = 80
  description = "Port for health checks"
}

variable "nlb_healthcheck_path" {
  type        = string
  default     = "/"
  description = "Path for health checks"
}
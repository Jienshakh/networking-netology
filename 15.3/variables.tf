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


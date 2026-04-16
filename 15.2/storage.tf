resource "yandex_storage_bucket" "lab_bucket" {
  bucket   = var.lab_bucket_name
  max_size = var.lab_bucket_size

  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }

}

resource "yandex_storage_object" "lab_picture" {
  bucket = var.lab_bucket_name
  key    = var.bucket_object_name
  source = var.bucket_object_path
  depends_on = [
    yandex_storage_bucket.lab_bucket
  ]
}
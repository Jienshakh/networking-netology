

######### KMS ############

resource "yandex_kms_symmetric_key" "my_key" {
  name              = "my-symetric-key"
  description       = "key for encrypt data in Object Storage buckets"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
}

####### Bucket ##########

resource "yandex_storage_bucket" "lab_bucket" {
  bucket   = var.lab_bucket_name
  max_size = var.lab_bucket_size

  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.my_key.id
        sse_algorithm     = "aws:kms"
      }
    }
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
output "lab-networking" {
  value = {
    vm_nat = {
      instance_name = yandex_compute_instance.vm_nat.name
      external_ip   = yandex_compute_instance.vm_nat.network_interface[0].nat_ip_address
      fqdn          = yandex_compute_instance.vm_nat.fqdn
    }
    vm_public = {
      instance_name = yandex_compute_instance.vm_public.name
      external_ip   = yandex_compute_instance.vm_public.network_interface[0].nat_ip_address
      fqdn          = yandex_compute_instance.vm_public.fqdn
    }
    vm_private = {
      instance_name = yandex_compute_instance.vm_private.name
      internal_ip   = yandex_compute_instance.vm_private.network_interface[0].ip_address
      fqdn          = yandex_compute_instance.vm_private.fqdn
    }
  }
}
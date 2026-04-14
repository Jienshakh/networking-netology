resource "yandex_vpc_network" "lab-net" {
  name = var.vpc_net_name
}

resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_public_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.lab-net.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.vpc_private_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.lab-net.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.private-route-table.id
}

## NAT-instance

resource "yandex_compute_instance" "vm_nat" {
  name        = var.vm_nat_name
  platform_id = var.vm_nat_platform_id
  resources {
    cores         = var.vm_nat_cores
    memory        = var.vm_nat_memory
    core_fraction = var.vm_nat_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.vm_nat_image_id
  }
}
  scheduling_policy {
    preemptible = var.vm_nat_preemptible
  }
  
  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    nat        = true
    ip_address = var.vm_nat_ip_address
  }

  metadata = {
    serial-port-enable = var.vm_nat_serial_port_enable
    ssh-keys           = "ubuntu:${file("~/.ssh/id_ed25519_yd.pub")}"
  }

}

## VM public subnet

data "yandex_compute_image" "ubuntu" {
  family = var.vm_os_family
}

resource "yandex_compute_instance" "vm_public" {
  name        = var.vm_public_platform_name
  platform_id = var.vm_public_platform_id
  resources {
    cores         = var.vm_public_cores
    memory        = var.vm_public_memory
    core_fraction = var.vm_public_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_public_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vm_public_serial_port_enable
    ssh-keys           = "ubuntu:${file("~/.ssh/id_ed25519_yd.pub")}"
  }

}

resource "yandex_compute_instance" "vm_private" {
  name        = var.vm_private_platform_name
  platform_id = var.vm_private_platform_id
  resources {
    cores         = var.vm_private_cores
    memory        = var.vm_private_memory
    core_fraction = var.vm_private_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_private_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }

  metadata = {
    serial-port-enable = var.vm_private_serial_port_enable
    ssh-keys           = "ubuntu:${file("~/.ssh/id_ed25519_yd.pub")}"
  }

}

resource "yandex_vpc_route_table" "private-route-table" {
  network_id = yandex_vpc_network.lab-net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.vm_nat_ip_address
  }
}
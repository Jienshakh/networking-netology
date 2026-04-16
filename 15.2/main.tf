resource "yandex_vpc_network" "lab-net" {
  name = var.vpc_net_name
}

resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_public_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.lab-net.id
  v4_cidr_blocks = var.public_cidr
}

## Instance Group

resource "yandex_compute_instance_group" "lamp_group" {
  name               = var.ig_name
  service_account_id = var.ig_service_account_id
  
  instance_template {
    platform_id = var.ig_platform_id
    
    resources {
      memory = var.ig_memory
      cores  = var.ig_cores
    }
    
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.ig_image_id
        size     = var.ig_disk_size
      }
    }
    
    network_interface {
      network_id = yandex_vpc_network.lab-net.id
      subnet_ids = [yandex_vpc_subnet.public.id]
      nat        = true
    }

    metadata = {
      serial-port-enable = var.ig_serial_port_enable
      ssh-keys           = "${var.ig_ssh_user}:${file(var.ig_ssh_key_path)}"
      user-data = templatefile("${path.module}/user-data.sh.tpl", {
        bucket_name = var.lab_bucket_name
        object_key  = var.bucket_object_name
      })
    }

    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.ig_scale_size
    }
  }

  allocation_policy {
    zones = var.ig_zones
  }

  deploy_policy {
    max_unavailable = var.ig_max_unavailable
    max_creating    = var.ig_max_creating
    max_expansion   = var.ig_max_expansion
    max_deleting    = var.ig_max_deleting
  }

  health_check {
    healthy_threshold   = var.ig_health_check_healthy_threshold
    unhealthy_threshold = var.ig_health_check_unhealthy_threshold
    interval            = var.ig_health_check_interval
    timeout             = var.ig_health_check_timeout
    
    http_options {
      port = var.ig_health_check_port
      path = var.ig_health_check_path
    }
  }

  load_balancer {
    target_group_name = var.ig_target_group_name
  }
}


## NLB

resource "yandex_lb_network_load_balancer" "my_nlb" {
  name = var.nlb_name

  listener {
    name = var.nlb_listener_name
    port = var.nlb_listener_port
    target_port = var.nlb_listener_target_port
    external_address_spec {
      ip_version = var.nlb_ip_version
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp_group.load_balancer.0.target_group_id

    healthcheck {
      name = var.nlb_healthcheck_name
      healthy_threshold   = var.nlb_healthcheck_healthy_threshold
      unhealthy_threshold = var.nlb_healthcheck_unhealthy_threshold
      interval            = var.nlb_healthcheck_interval
      timeout             = var.nlb_healthcheck_timeout
      
      http_options {
        port = var.nlb_healthcheck_port
        path = var.nlb_healthcheck_path
      }
    }
  }
}

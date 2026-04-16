###### Instance group

output "ig_external_ips" {
  description = "External IP addresses of all instances in the group"
  value = [
    for inst in yandex_compute_instance_group.lamp_group.instances :
    inst.network_interface[0].nat_ip_address
  ]
}

###### NLB

output "nlb_external_ip" {
  description = "External IP address of the Network Load Balancer"
  value = [
    for listener in yandex_lb_network_load_balancer.my_nlb.listener :
    [for spec in listener.external_address_spec : spec.address][0]
  ][0]
}

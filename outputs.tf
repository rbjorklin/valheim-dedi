output "status" {
  value = [hcloud_server.node.status]
}

output "datacenter" {
  value = [hcloud_server.node.datacenter]
}

output "address" {
  value = "${hcloud_server.node.ipv4_address}:${var.port}"
}

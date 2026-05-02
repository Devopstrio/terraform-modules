output "dev_vpc_id" {
  value = module.network.vpc_id
}

output "web_server_ip" {
  value = module.web_server.private_ip
}

output "eks_endpoint" {
  value = module.app_cluster.cluster_endpoint
}

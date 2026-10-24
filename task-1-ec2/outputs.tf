output "instance_ids" {
  description = "Map of all instance names to their EC2 Instance IDs."
  value       = module.ec2_cluster.instance_ids
}

output "instance_private_ips" {
  description = "Map of all instance names to their Private IP addresses."
  value       = module.ec2_cluster.instance_private_ips
}
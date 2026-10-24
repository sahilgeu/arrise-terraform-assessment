output "instance_ids" {
  description = "Combined map of all instance names to their EC2 Instance IDs."
  value = merge(
    { for k, v in aws_instance.standard : k => v.id },
    { "db-primary" = aws_instance.db_primary.id }
  )
}

output "instance_private_ips" {
  description = "Combined map of all instance names to their Private IP addresses."
  value = merge(
    { for k, v in aws_instance.standard : k => v.private_ip },
    { "db-primary" = aws_instance.db_primary.private_ip }
  )
}
# Terraform Multi-Instance EC2 Provisioning Module

## Architecture Overview
- **Root and Child Modules**: Configuration is separated into a root module (handling inputs and orchestration) and a reusable child module located in `modules/ec2_instances`.
- **Single Variable Strategy**: All 5 EC2 instances are driven cleanly from a single input map variable (`var.instances`) defined in `terraform.tfvars`.
- **Storage Compliance**: Supports diverse AWS EBS storage classes including `gp2`, `gp3`, and high-performance provisioned IOPS storage (`io2` with explicitly configured IOPS for the database).
- **Tagging**: Every instance is automatically tagged with `Name`, `Environment`, and `Owner`.

---

## Lifecycle Protection Explanation

### Protected Instance: `db-primary`
- **Protection Mechanism**: The `db-primary` node is isolated into its own resource block (`aws_instance.db_primary`) to apply `prevent_destroy = true` as a static, literal constant (fulfilling Terraform's core compilation requirement), while still pulling its configuration properties directly from the shared input variable.
- **Business Justification**: As the primary database node, it contains critical persistent business data. Accidental deletion or resource replacement triggered by infrastructure updates (`terraform apply` or `terraform destroy`) would cause severe data loss and downtime. This lifecycle rule acts as a strict safety barrier requiring intentional manual intervention in the state file before destruction can occur.

---

## Outputs
The module exposes two maps via the root outputs:
1. `instance_ids`: Maps instance names to their AWS EC2 Instance IDs.
2. `instance_private_ips`: Maps instance names to their Private IP addresses.
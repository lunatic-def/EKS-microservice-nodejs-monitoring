# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "EC2 instance ID"
  value       = module.bastion-instance.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  description = "Public IP address EC2 instance"
  value       = module.bastion-instance.public_ip
}
output "log_group_arns" {
  value       = module.cloudwatch.log_group_arns
  description = "Map of log group keys to their ARNs"
}

output "log_group_names" {
  value       = module.cloudwatch.log_group_names
  description = "Map of log group keys to their names"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "VPC CIDR block"
}

output "internet_gateway_id" {
  value       = module.vpc.internet_gateway_id
  description = "Internet gateway ID"
}

output "security_group_id" {
  value       = module.security_group.security_group_id
  description = "Security group ID"
}

output "security_group_arn" {
  value       = module.security_group.security_group_arn
  description = "Security group ARN"
}

output "subnet_id" {
  value       = module.subnet.subnet_id
  description = "Subnet ID"
}

output "subnet_cidr_block" {
  value       = module.subnet.subnet_cidr_block
  description = "Subnet CIDR block"
}

output "role_arn" {
  value       = module.iam_role.role_arn
  description = "IAM role ARN"
}

output "role_name" {
  value       = module.iam_role.role_name
  description = "IAM role name"
}

output "instance_id" {
  value       = module.ec2.instance_id
  description = "EC2 instance ID"
}

output "instance_arn" {
  value       = module.ec2.instance_arn
  description = "EC2 instance ARN"
}

output "public_ip" {
  value       = module.ec2.public_ip
  description = "EC2 instance public IP"
}

output "private_ip" {
  value       = module.ec2.private_ip
  description = "EC2 instance private IP"
}

output "availability_zone" {
  value       = module.ec2.availability_zone
  description = "EC2 instance availability zone"
}

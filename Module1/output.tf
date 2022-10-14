output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}


output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}


output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}
output "database_subnet_group_name" {
  description = "Name of database subnet group"
  value       = module.vpc.database_subnet_group_name
}


output "Bastionsecurity_group_arn" {
  description = "The ARN of the security group"
  value       = module.Bastion_sg.security_group_arn
}

output "Bastion_security_group_id" {
  description = "The ID of the security group"
  value       = module.Bastion_sg.security_group_id
}

output "Bastion_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.Bastion_sg.security_group_vpc_id
}



output "Private_security_group_arn" {
  description = "The ARN of the security group"
  value       = module.Private_sg.security_group_arn
}

output "Private_security_group_id" {
  description = "The ID of the security group"
  value       = module.Private_sg.security_group_id
}

output "Private_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.Private_sg.security_group_vpc_id
}



output "rds_security_group_arn" {
  description = "The ARN of the security group"
  value       = module.RDS_sg.security_group_arn
}

output "rds_security_group_id" {
  description = "The ID of the security group"
  value       = module.RDS_sg.security_group_id
}

output "rds_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.RDS_sg.security_group_vpc_id
}



output "alb_security_group_arn" {
  description = "The ARN of the security group"
  value       = module.alb_sg.security_group_arn
}

output "alb_security_group_id" {
  description = "The ID of the security group"
  value       = module.alb_sg.security_group_id
}

output "alb_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.alb_sg.security_group_vpc_id
}
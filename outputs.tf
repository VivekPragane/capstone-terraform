output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "app_subnet_ids" {
  value = module.subnets.app_subnet_ids
}

output "db_subnet_ids" {
  value = module.subnets.db_subnet_ids
}

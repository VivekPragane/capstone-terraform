resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge({
    Name        = var.name
    Environment = var.environment
    Project     = "capstone"
  }, var.tags)
}



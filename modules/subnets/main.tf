locals {
  az_count = length(var.azs)

  public_cidrs = [
    for i in range(local.az_count) : cidrsubnet(var.vpc_cidr, 8, i)
  ]

  app_cidrs = [
    for i in range(local.az_count) : cidrsubnet(var.vpc_cidr, 8, i + local.az_count)
  ]

  db_cidrs = [
    for i in range(local.az_count) : cidrsubnet(var.vpc_cidr, 8, i + (2 * local.az_count))
  ]
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each = { for idx, az in var.azs : idx => az }

  vpc_id                  = var.vpc_id
  cidr_block              = local.public_cidrs[tonumber(each.key)]
  availability_zone       = each.value
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-${each.value}"
    Tier        = "public"
    Environment = var.environment
    Owner       = var.owner
    Project     = "capstone"
  }
}

# Private APP Subnets
resource "aws_subnet" "app" {
  for_each = { for idx, az in var.azs : idx => az }

  vpc_id                  = var.vpc_id
  cidr_block              = local.app_cidrs[tonumber(each.key)]
  availability_zone       = each.value
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-app-${each.value}"
    Tier        = "private-app"
    Environment = var.environment
    Owner       = var.owner
    Project     = "capstone"
  }
}

# Private DB Subnets
resource "aws_subnet" "db" {
  for_each = { for idx, az in var.azs : idx => az }

  vpc_id                  = var.vpc_id
  cidr_block              = local.db_cidrs[tonumber(each.key)]
  availability_zone       = each.value
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-db-${each.value}"
    Tier        = "private-db"
    Environment = var.environment
    Owner       = var.owner
    Project     = "capstone"
  }
}

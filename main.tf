module "vpc" {
  source      = "./modules/vpc"
  name        = "capstone-vpc"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr

  # optional extra tags
  tags = {
    Owner = "Vivek"
  }
}

module "subnets" {
  source      = "./modules/subnets"
  vpc_id      = module.vpc.vpc_id
  vpc_cidr    = module.vpc.vpc_cidr
  azs         = ["ap-south-1a", "ap-south-1b"]
  environment = var.environment
  owner       = "Vivek"
}

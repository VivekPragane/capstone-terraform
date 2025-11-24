terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "capstone-tfstate-vivek-001"  
    key            = "global/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "capstone-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "capstone-project"
      Environment = var.environment
      Owner       = "vivek"
    }
  }
}

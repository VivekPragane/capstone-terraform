variable "vpc_id" {
  description = "ID of the VPC where subnets will be created"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR of the VPC used for subnet calculations"
  type        = string
}

variable "azs" {
  description = "Availability Zones to create subnets in"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner tag"
  type        = string
  default     = "Vivek"
}

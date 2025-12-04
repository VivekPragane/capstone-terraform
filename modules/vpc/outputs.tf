output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = aws_vpc.this.cidr_block
}

output "vpc_default_tags" {
  description = "Default tags applied to the VPC"
  value       = aws_vpc.this.tags
}

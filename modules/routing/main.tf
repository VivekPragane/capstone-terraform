########################################
# Internet Gateway
########################################
resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name    = "capstone-igw"
    Project = "capstone-project"
  }
}

########################################
# Public Route Table
########################################
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name    = "capstone-public-rt"
    Project = "capstone-project"
  }
}

########################################
# Default route to Internet Gateway
########################################
resource "aws_route" "public_default_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

########################################
# Associate Public Route Table to Public Subnets
########################################
resource "aws_route_table_association" "public_assoc" {
  for_each = toset(var.public_subnet_ids)

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

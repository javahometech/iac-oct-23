resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  tags             = var.tags
  instance_tenancy = "default"
}
# Create public subnets in the VPC for each availability zone
resource "aws_subnet" "public" {
  count             = length(local.az_names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = element(local.az_names, count.index)
}
# create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}
# create route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
# associate route table with public subnets
resource "aws_route_table_association" "public" {
  count          = length(local.az_names)
  subnet_id      = element(local.pub_sub_ids, count.index)
  route_table_id = aws_route_table.public.id
}
# Create private subnets in the VPC for each availability zone
resource "aws_subnet" "private" {
  count             = length(local.az_names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + length(local.az_names))
  availability_zone = element(local.az_names, count.index)
}

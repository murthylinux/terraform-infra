resource "aws_vpc" "vc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "viking-vpc"
  }
}

resource "aws_internet_gateway" "vc_igw" {
  vpc_id = aws_vpc.vc.id
  tags = {
    Name = "viking-igw"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "vc_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.vc_public[0].id
  tags = {
    Name = "viking-nat"
  }
}

resource "aws_subnet" "vc_public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.vc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "viking-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "vc_private" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.vc.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "viking-private-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "vc_public" {
  vpc_id = aws_vpc.vc.id
  tags = {
    Name = "viking-public-rt"
  }
}

resource "aws_route" "vc_public_internet" {
  route_table_id         = aws_route_table.vc_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vc_igw.id
}

resource "aws_route_table_association" "vc_public" {
  count          = length(aws_subnet.vc_public)
  subnet_id      = aws_subnet.vc_public[count.index].id
  route_table_id = aws_route_table.vc_public.id
}

resource "aws_route_table" "vc_private" {
  vpc_id = aws_vpc.vc.id
  tags = {
    Name = "viking-private-rt"
  }
}

resource "aws_route" "vc_private_nat" {
  route_table_id         = aws_route_table.vc_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.vc_nat.id
}

resource "aws_route_table_association" "vc_private" {
  count          = length(aws_subnet.vc_private)
  subnet_id      = aws_subnet.vc_private[count.index].id
  route_table_id = aws_route_table.vc_private.id
}

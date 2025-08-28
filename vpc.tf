#VPC
resource "aws_vpc" "myvpc" {
  cidr_block       = var.cidr_vpc
  instance_tenancy = "default"
  tags = merge( local.common_tags, { Name = "${local.name}-vpc"})

}

# IGW
resource "aws_internet_gateway" "tigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = merge( local.common_tags, { Name = "${local.name}-igw"})
}

#SUBNET
#Pub subnet -1
resource "aws_subnet" "pubsub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.subpub1
  availability_zone = var.az_sub_pub1
  map_public_ip_on_launch = true
  tags = merge( local.common_tags, { Name = "${local.name}-pubsub-1"})
}
#Pub subnet -2
resource "aws_subnet" "pubsub2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.subpub2
  availability_zone = var.az_sub_pub2
  map_public_ip_on_launch = true
  tags = merge( local.common_tags, { Name = "${local.name}-pubsub-2"})
}

#Pvt Subnet-1
resource "aws_subnet" "pvtsub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.subpvt1
  availability_zone = var.az_sub_pvt1
  tags = merge( local.common_tags, { Name = "${local.name}-pvtsub-1"})
}

#Pvt Subnet-2
resource "aws_subnet" "pvtsub2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.subpvt2
  availability_zone = var.az_sub_pvt2
  tags = merge( local.common_tags, { Name = "${local.name}-pvtsub-2"})
}

#ROUTE TABLE
#PUB-RT-1
resource "aws_route_table" "pubrt1" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tigw.id
  }
  tags = merge( local.common_tags, { Name = "${local.name}-pub-rt-1"})
}

#PUB-RT-2
resource "aws_route_table" "pubrt2" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tigw.id
  }
  tags = merge( local.common_tags, { Name = "${local.name}-pub-rt-2"})
}

#PVT-RT-1
resource "aws_route_table" "pvtrt1" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pvtnat1.id
  }
  tags = merge( local.common_tags, { Name = "${local.name}-pvt-rt-1"})
}

#PVT-RT-2
resource "aws_route_table" "pvtrt2" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pvtnat1.id
  }
  tags = merge( local.common_tags, { Name = "${local.name}-pvt-rt-2"})
}

#EIP-1
resource "aws_eip" "eip1" {
    vpc = true
 
}
#EIP-2
resource "aws_eip" "eip2" {
    vpc = true
  
}
# NAT GATEWAY-1
resource "aws_nat_gateway" "pvtnat1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.pubsub1.id
  tags = merge( local.common_tags, { Name = "${local.name}-nat-1"})
}
# NAT GATEWAY-2
resource "aws_nat_gateway" "pvtnat2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.pubsub2.id
  tags = merge( local.common_tags, { Name = "${local.name}-nat-2"})
}
# ROUTE TABLE ASS
# ASCPUB-SUB-1
resource "aws_route_table_association" "pubasc1" {
  subnet_id      = aws_subnet.pubsub1.id
  route_table_id = aws_route_table.pubrt1.id
}

# ASCPUB-SUB-2
resource "aws_route_table_association" "pubasc2" {
  subnet_id      = aws_subnet.pubsub2.id
  route_table_id = aws_route_table.pubrt2.id
}
# ASCPVT-SUB-1
resource "aws_route_table_association" "pvtasc1" {
  subnet_id      = aws_subnet.pvtsub1.id
  route_table_id = aws_route_table.pvtrt1.id
}

# ASCPVT-SUB-2
resource "aws_route_table_association" "pvtasc2" {
  subnet_id      = aws_subnet.pvtsub2.id
  route_table_id = aws_route_table.pvtrt2.id
}
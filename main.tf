# locals{
#     front_subnet_id = flatten([aws_subnet.public_subnet1.id,aws_subnet.public_subnet2.id])
#     app_subnet_id = flatten([aws_subnet.app_subnet1.id,aws_subnet.app_subnet2.id])
#     db_subnet_id = flatten([aws_subnet.db_subnet1.id,aws_subnet.db_subnet2.id])
# }

resource "aws_vpc" "Main" {
   cidr_block       = "${var.vpc_cidr}"
   instance_tenancy = "default"
   enable_dns_support   = true 
   enable_dns_hostnames = true
   tags = {
        Name = "${var.vpc_name}"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
    }
 }

resource "aws_internet_gateway" "IGW" {
    vpc_id =  aws_vpc.Main.id
    tags = {
        Name = "${var.vpc_name}-IGW"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
    }
 }

data "aws_availability_zones" "available" {}

resource "aws_subnet" "publicsubnet1" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.public_subnet1_cidr}"
   availability_zone = data.aws_availability_zones.available.names[0]
   map_public_ip_on_launch = "true"
   tags = {
        Name = "${var.vpc_name}-PublicSubnet1"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
        Tier = "Front"
    }
 }

resource "aws_subnet" "publicsubnet2" { 
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.public_subnet2_cidr}"
   availability_zone = data.aws_availability_zones.available.names[1]
   map_public_ip_on_launch = "true"
   tags = {
        Name = "${var.vpc_name}-PublicSubnet2"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
        Tier = "Front"
    }
 }

resource "aws_subnet" "appsubnet1" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.app_subnet1_cidr}"
   availability_zone = data.aws_availability_zones.available.names[0]
   map_public_ip_on_launch = false
   tags = {
        Name = "${var.vpc_name}-AppSubnet1"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
        Tier = "Application"
    }
 }

resource "aws_subnet" "appsubnet2" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.app_subnet2_cidr}"
   availability_zone = data.aws_availability_zones.available.names[1]
   map_public_ip_on_launch = false
   tags = {
        Name = "${var.vpc_name}-AppSubnet2"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
        Tier = "Application"
    }
 }

resource "aws_subnet" "dbsubnet1" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.app_subnet1_cidr}"          
   availability_zone = data.aws_availability_zones.available.names[0]
   map_public_ip_on_launch = false
   tags = {
        Name = "${var.vpc_name}-DBSubnet1"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
        Tier = "Database"
    }
 }

resource "aws_subnet" "dbsubnet2" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.app_subnet2_cidr}"
   availability_zone = data.aws_availability_zones.available.names[1]
   map_public_ip_on_launch = false
   tags = {
        Name = "${var.vpc_name}-DBSubnet2"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
        Tier = "Database"
    }
 }

resource "aws_route_table" "PublicRT" {
    vpc_id =  aws_vpc.Main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
  }
    tags = {
        Name = "${var.vpc_name}-PublicRT"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
    }
 }
resource "aws_route_table_association" "PublicRTassociation1" {
    subnet_id = aws_subnet.publicsubnet1.id
    route_table_id = aws_route_table.PublicRT.id
 }
resource "aws_route_table_association" "PublicRTassociation2" {
    subnet_id = aws_subnet.publicsubnet2.id
    route_table_id = aws_route_table.PublicRT.id
 }

resource "aws_eip" "nateIP" {
   count = "${var.enable_nat == true ? 1 : 0}"
   vpc   = true
   tags = {
        Name = "${var.vpc_name}-NAT-EIP"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
    }
 }

resource "aws_nat_gateway" "NATgw" {
   count = "${var.enable_nat == true ? 1 : 0}"
   allocation_id = aws_eip.nateIP[count.index].allocation_id
   subnet_id = aws_subnet.publicsubnet1.id
   tags = {
        Name = "${var.vpc_name}-NAT"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
    }
 }

resource "aws_route_table" "PrivateRT" {
    vpc_id =  aws_vpc.Main.id
    tags = {
        Name = "${var.vpc_name}-PrivateRT"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
    }
 }

resource "aws_route_table_association" "PrivateRTassociation1" {
    subnet_id = aws_subnet.appsubnet1.id
    route_table_id = aws_route_table.PrivateRT.id
 }

resource "aws_route_table_association" "PrivateRTassociation2" {
    subnet_id = aws_subnet.appsubnet2.id
    route_table_id = aws_route_table.PrivateRT.id
 }

resource "aws_route_table_association" "PrivateRTassociation3" {
    subnet_id = aws_subnet.dbsubnet1.id
    route_table_id = aws_route_table.PrivateRT.id
 }

resource "aws_route_table_association" "PrivateRTassociation4" {
    subnet_id = aws_subnet.dbsubnet2.id
    route_table_id = aws_route_table.PrivateRT.id
 }

resource "aws_security_group" "default" {
  name        = "${var.vpc_name}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.Main.id
  tags = {
        Name = "${var.vpc_name}-default-sg"
        Environment = "${var.env}"
        Creator = "${var.creator}"
        Project_Code = "${var.prjcode}"
    }
}

resource "aws_route" "nat" {
  count = "${var.enable_nat == true ? 1 : 0}"
  route_table_id            = aws_route_table.PrivateRT.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id =  aws_nat_gateway.NATgw[count.index].id
  depends_on                = [aws_route_table.PrivateRT]
} 

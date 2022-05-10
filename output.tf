output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.Main.id
}

output "vpc_cidr" {
  description = "The CIDR of the VPC"
  value       = aws_vpc.Main.cidr_block
}

output "front_subnet1" {
  description = "The ID of the Front subnet"
  value = aws_subnet.publicsubnet1.id
}
output "front_subnet2" {
  description = "The ID of the Front subnet"
  value = aws_subnet.publicsubnet2.id
}

output "app_subnet1" {
  description = "The ID of the APP subnet"
  value = aws_subnet.appsubnet1.id
}
output "app_subnet2" {
  description = "The ID of the APP subnet"
  value = aws_subnet.appsubnet2.id
}
output "db_subnet1" {
  description = "The ID of the DB subnet"
  value = aws_subnet.dbsubnet1.id
}
output "db_subnet2" {
  description = "The ID of the DB subnet"
  value = aws_subnet.dbsubnet2.id
}
output "publicrt" {
  description = "The ID of Public RT"
  value = aws_route_table.PublicRT.id
}

output "privatert" {
    description = "The ID of Private RT"
    value = aws_route_table.PrivateRT.id
}

output "default_sg" {
    description = "The ID of Default security group"
    value = aws_security_group.default.id
}
variable "region" {
  type = string
  description = "AWS region code"
}

variable "profile" {
  type = string
  description = "AWS Profile"
}

variable "vpc_name" {
  type = string
  description = "Name of VPC"
}

variable "vpc_cidr"{
    type = string
    description = "CIDR of VPC"
}

variable "env" {
  type = string
  description = "Name of Environment - PR/UT/PP"
}

variable "creator" {
  type = string
  description = "Name of the Infrastructure Creator"
}
variable "prjcode" {
  type = string
  description = "Name of the Project - Code"
}
variable "public_subnet1_cidr" {
  type = string
  description = "CIDR of Public subnet 1"
}
variable "public_subnet2_cidr" {
  type = string
  description = "CIDR of Public subnet 2"
}
variable "app_subnet1_cidr" {
  type = string
  description = "CIDR of App subnet 1"
}
variable "app_subnet2_cidr" {
  type = string
  description = "CIDR of App subnet 2"
}
variable "db_subnet1_cidr" {
  type = string
  description = "CIDR of DB subnet 1"
}
variable "db_subnet2_cidr" {
  type = string
  description = "CIDR of DB subnet 2"
}
variable "enable_nat" {
  type = bool
  description = "Whether to enable NAT - true/false"
}
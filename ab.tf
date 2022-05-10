backend "local"{
    path = "C:/Users/abhis/OneDrive - MINFY TECHNOLOGIES PRIVATE LIMITED/Desktop/Minfy-TF/terraform.tfstate.d"
}

module "vpc" {
    source = "C:/Users/abhis/OneDrive - MINFY TECHNOLOGIES PRIVATE LIMITED/Desktop/Minfy-TF/VPC"
    region = "ap-south-1"
    profile = "abtest"
    vpc_name = "Test-VPC"
    vpc_cidr = "10.0.0.0/24"
    env = "np"
    creator = "ab"
    prjcode = "tst"
    public_subnet1_cidr = "10.0.0.0/27"
    public_subnet2_cidr = "10.0.0.32/27"
    app_subnet1_cidr = "10.0.0.64/26"
    app_subnet2_cidr = "10.0.0.128/26"
    db_subnet1_cidr = "10.0.0.192/27"
    db_subnet2_cidr = "10.0.0.224/27"
    enable_nat = true
}
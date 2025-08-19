#Get region#
data "aws_region" "current" {}

##Create a Network Module##
module "lab_vpc"{
  source = "./Modules/vpc"

  lab_vpc = {
    cidr_block            = "10.0.0.0/16"
    enable_dns_host_names = true
    enable_dns_support    = true
    availability_zones    = ["us-east-1a", "us-east-1b"]

    tags = {
      name = "tf_main"
    }

  }
}

#Enable SSM Module#
module "SSM" {
  source = "./Modules/ssm"
  
}
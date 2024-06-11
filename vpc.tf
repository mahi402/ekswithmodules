locals {
  cluster_name = "my-cluster"
}
module "my_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "172.29.0.0/16"
  #secondary_cidr_blocks = ["10.100.0.0/16"]
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["172.29.1.0/24", "172.29.2.0/24", "172.29.3.0/24", "172.29.4.0/24"]
  public_subnets  = ["172.29.101.0/24", "172.29.102.0/24", "172.29.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "test"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    "kubernetes.io/role/internal-elb"             = "1"
  }

}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}
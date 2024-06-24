module "eks" {
  source = "terraform-aws-modules/eks/aws"
  #version = "~> 20.0"
  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true
  cluster_service_ipv4_cidr = "10.100.0.0/16"
  vpc_id = module.my_vpc.vpc_id
  subnet_ids = [module.my_vpc.private_subnets[0], module.my_vpc.private_subnets[1]]
 
  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true
  tags = {
    Environment = "dev"
    Terraform = "true"
  }
  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t3.medium"]
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  eks_managed_node_groups = {

    node_group = {
      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }

}

module "eks_auth" {
 
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  manage_aws_auth_configmap = true
  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::66666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::66666666666:user/mahender"
      username = "mahender"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::66666666666:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_accounts = [
    "777777777777",
    "888888888888",
  ]
}
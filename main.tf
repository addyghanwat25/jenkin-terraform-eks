
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC and networking
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false
  map_public_ip_on_launch = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  tags = {
    Project = "Terraform-EKS"
  }
}

# EKS cluster and managed worker nodes
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.1"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  cluster_endpoint_public_access = true

  # Allow the Terraform identity to administer the cluster
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  eks_managed_node_groups = {
    default = {
      name           = "nodes"
      instance_types = [var.instance_type]

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      iam_role_name            = "${var.cluster_name}-node-role"
      iam_role_use_name_prefix = false
    }
  }

  tags = {
    Project = "Terraform-EKS"
  }
}

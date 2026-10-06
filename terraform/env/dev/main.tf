################################################################################
# DEV Environment — Medical B2B ERP
################################################################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  # Remote state — use S3 backend
  backend "s3" {
    bucket         = "medflow-terraform-state-342719020675"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "medflow-terraform-locks"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

locals {
  environment  = "dev"
  project      = "med-erp"
  cluster_name = "${local.project}-${local.environment}-eks"

  common_tags = {
    Project     = local.project
    Environment = local.environment
    ManagedBy   = "Terraform"
    Owner       = "DevOps"
  }
}

# ── VPC ────────────────────────────────────────────────────────────────────────
module "vpc" {
  source       = "../../modules/vpc"
  name         = "${local.project}-${local.environment}"
  vpc_cidr     = "10.10.0.0/16"
  cluster_name = local.cluster_name
  tags         = local.common_tags
}

# ── EKS ────────────────────────────────────────────────────────────────────────
module "eks" {
  source              = "../../modules/eks"
  cluster_name        = local.cluster_name
  kubernetes_version  = "1.37"
  vpc_id              = module.vpc.vpc_id
  vpc_cidr            = module.vpc.vpc_cidr
  private_subnet_ids  = module.vpc.private_subnet_ids
  node_instance_types = ["c7i-flex.large"]
  capacity_type       = "SPOT" # Use Spot for dev cost savings
  node_desired_count  = 1
  node_min_count      = 1
  node_max_count      = 2
  public_endpoint     = true # Allow kubectl from dev machines
  public_access_cidrs = [var.developer_ip_cidr]
  tags                = local.common_tags
}

# ── ECR ────────────────────────────────────────────────────────────────────────
module "ecr" {
  source  = "../../modules/ecr"
  project = local.project
  tags    = local.common_tags
}

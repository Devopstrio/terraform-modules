terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "network" {
  source = "../../modules/networking"

  vpc_name   = "dev-vpc"
  cidr_block = "10.10.0.0/16"
}

module "web_server" {
  source = "../../modules/compute"

  instance_name = "dev-web-server"
  subnet_id     = module.network.public_subnet_id
  tags = {
    Environment = "dev"
    Service     = "Frontend"
  }
}

module "assets_bucket" {
  source = "../../modules/storage"

  bucket_name = "dev-assets-bucket-devopstrio"
}

module "app_cluster" {
  source = "../../modules/kubernetes"

  cluster_name = "dev-eks-cluster"
  subnet_ids   = [module.network.public_subnet_id]
}

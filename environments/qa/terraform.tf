provider "aws" {
  region                      = "sa-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

// Descomentar para caso tiver o s3 configurado
/* terraform {
  backend "s3" {
    encrypt = true
    profile = "teste"
    region  = "us-east-1"
    bucket  = "teste-terraform-state"
    key     = "environments/qa/ecs-cluster/terraform.tfstate"
  }
} */

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

// Descomentar para caso tiver o s3 configurado
/* data "terraform_remote_state" "ecs_cluster" {
  backend = "s3"

  config = {
    profile = "teste"
    region  = "us-east-1"
    bucket  = "teste-terraform-state"
    key     = "environments/qa/ecs-cluster/terraform.tfstate"
  }
}

data "terraform_remote_state" "ecs_service" {
  backend = "s3"

  config = {
    profile = "teste"
    region  = "us-east-1"
    bucket  = "teste-terraform-state"
    key     = "environments/qa/ecs-service/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    profile = "teste"
    region  = "us-east-1"
    bucket  = "teste-terraform-state"
    key     = "environments/qa/vpc/terraform.tfstate"
  }
} */

// FIXME: Apenas para teste
locals {
  cluster_name = "teste_cluster"
  service_name = "teste_servico"
}

module "vpc" {
  source = "./vpc"
}

module "ecs_cluster" {
  source       = "../../modules/ecs-cluster"
  max_capacity = 2
  min_capacity = 1

  cluster_name = local.cluster_name
  service_name = local.service_name

  // ecs_cluster_name = "teste_cluster"
  // service_name = data.terraform_remote_state.ecs_service.outputs.service_name

  tags = {}
}

module "ecs_service" {
  source = "../../modules/api"

  ecs_cluster_name = local.cluster_name
  // ecs_cluster_name = data.terraform_remote_state.ecs_cluster.outputs.cluster_name

  service_name = local.service_name
  // service_name = "teste_service"
  ecs_service_count    = 1
  family_name          = "teste_familia"
  container_definition = file("./container_definition.json")

  depends_on = [module.ecs_cluster]
}

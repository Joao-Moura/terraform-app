provider "aws" {
  region = "sa-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
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
} */

// FIXME: Apenas para teste
locals {
  cluster_name = "teste_cluster"
}

module "ecs_service" {
  source = "../../modules/api"

  ecs_cluster_name = local.cluster_name
  // ecs_cluster_name = data.terraform_remote_state.ecs_cluster.outputs.cluster_name

  service_name = "teste_servico"
  ecs_service_count = 1
  family_name = "teste_familia"
  container_definition = file("./container_definition.json")
}

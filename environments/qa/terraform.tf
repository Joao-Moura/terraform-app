data "terraform_remote_state" "ecs_cluster" {
  backend = "s3"

  config = {
    profile = "teste"
    region  = "us-east-1"
    bucket  = "teste-terraform-state"
    key     = "environments/qa/ecs-cluster/terraform.tfstate"
  }
}

module "ecs_service" {
  source = "../../modules/api"

  ecs_cluster_name = data.terraform_remote_state.ecs_cluster.outputs.cluster_name

  service_name = "teste_servico"
  ecs_service_count = 1
  family_name = "teste_familia"
  container_definition = file("./container_definition.json")
}

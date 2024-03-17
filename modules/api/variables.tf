variable "ecs_cluster_name" {
  type        = string
  description = "Nome do cluster ecs"
}

variable "service_name" {
  type        = string
  description = "Nome do serviço ecs"
}

variable "ecs_service_count" {
  type        = number
  description = "Número de instâncias ecs"
}

variable "family_name" {
  type        = string
  description = "Nome da família da task definition"
}

variable "container_definition" {
  type        = string
  description = "Definição do conteiner ECS"
}

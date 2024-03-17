variable "cluster_name" {
  type        = string
  description = "Nome do cluster ecs"
}

variable "service_name" {
  type        = string
  description = "Nome do serviço ecs"
}

variable "max_capacity" {
  type        = number
  description = "Número máximo de instancias ECS"
}

variable "min_capacity" {
  type        = number
  description = "Número mínimo de instancias ECS"
}

variable "tags" {
  type        = map(string)
  description = "Tags para recursos"
}

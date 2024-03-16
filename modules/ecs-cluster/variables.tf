variable "cluster_name" {
  type        = string
  description = "Nome do cluster ecs"
}

variable "tags" {
  type        = map(string)
  description = "Tags para recursos"
}

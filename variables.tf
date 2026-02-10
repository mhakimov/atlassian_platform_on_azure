variable "project" {
  default = "atlassian-platform"
}

variable "aks_node_count" {
  default = 2
}

variable "allowed_ips" {
  type = list(string)
}

variable "location" {}
variable "postgres_admin_password" {}

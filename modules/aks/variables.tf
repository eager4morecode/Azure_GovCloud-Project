variable "cluster_name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "dns_prefix" { type = string }
variable "kubernetes_version" { type = string, default = "1.26.4" }
variable "node_count" { type = number, default = 3 }
variable "node_vm_size" { type = string, default = "Standard_D4s_v3" }
variable "tags" { type = map(string), default = {} }

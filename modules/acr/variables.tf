variable "acr_name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "sku" { type = string, default = "Premium" } # Premium enables geo-rep if needed
variable "tags" { type = map(string), default = {} }

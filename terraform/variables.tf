variable "subscription_id" {
  description = "Azure Government subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID for the Azure Government subscription"
  type        = string
}

variable "location" {
  description = "Azure region (example: usgovvirginia)"
  type        = string
  default     = "usgovvirginia"
}

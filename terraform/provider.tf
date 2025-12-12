# AzureRM provider configured for Azure Government
provider "azurerm" {
  features = {}

  # For Azure Government the provider supports environment = "usgovernment".
  # If your Terraform provider version or platform uses a different name,
  # adjust accordingly to your environment.
  environment     = "usgovernment"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

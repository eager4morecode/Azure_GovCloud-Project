terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.1"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io" # change to your TFE hostname for on-prem
    organization = "your-tfe-org"

    workspaces {
      prefix = "govproject-"
    }
  }
}

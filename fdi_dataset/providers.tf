terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }

    # https://github.com/aminueza/terraform-provider-minio
    minio = {
      source = "aminueza/minio"
      version = ">= 1.0.0"
    }
  }

  required_version = ">= 0.14.9"
}

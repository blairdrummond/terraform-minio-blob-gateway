# Configure the Azure provider

# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 0.7.0"
    }

    # https://github.com/aminueza/terraform-provider-minio
    minio = {
      source = "aminueza/minio"
      version = ">= 1.0.0"
    }

    aws = {
      source = "hashicorp/aws"
      version = "3.55.0"
    }

    #kubernetes = {
    #  source = "hashicorp/kubernetes"
    #  version = ">= 2.3.2"
    #}

    #helm = {
    #  source = "hashicorp/helm"
    #  version = ">= 2.2.0"
    #}

  }

  required_version = ">= 0.14.9"
}

# We are not actually connecting to AWS
# We're just using a helper function for
# managing IAM policies
provider "aws" {
  region = "us-east-1"
}

###
###       .o.
###      .888.
###     .8"888.       oooooooo oooo  oooo  oooo d8b  .ooooo.
###    .8' `888.     d'""7d8P  `888  `888  `888""8P d88' `88b
###   .88ooo8888.      .d8P'    888   888   888     888ooo888
###  .8'     `888.   .d8P'  .P  888   888   888     888    .o
### o88o     o8888o d8888888P   `V88V"V8P' d888b    `Y8bod8P'
###

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "fdidatalakeblob"
  location = "canadacentral"
}

resource "azurerm_storage_account" "datalake" {
  name                     = "blairlakeblob"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # See also StorageV2
  account_kind             = "BlobStorage"
  # Use object versioning instead
  is_hns_enabled           = "false"

  blob_properties {
    versioning_enabled       = "true"
    change_feed_enabled      = "true"
  }
}

###
###  ooo        ooooo  o8o              ooooo   .oooooo.
###  `88.       .888'  `"'              `888'  d8P'  `Y8b
###   888b     d'888  oooo  ooo. .oo.    888  888      888
###   8 Y88. .P  888  `888  `888P"Y88b   888  888      888
###   8  `888'   888   888   888   888   888  888      888
###   8    Y     888   888   888   888   888  `88b    d88'
###  o8o        o888o o888o o888o o888o o888o  `Y8bood8P'
###

provider "minio" {
  minio_server = var.minio_server
  minio_region = var.minio_region
  minio_access_key = var.minio_access_key
  minio_secret_key = var.minio_secret_key
}

# provider "helm" {
#   kubernetes {
#     # Use a LOCAL kubeconfig
#     config_path = ".kube/config"
#   }
# }
#
# # Assume the `fdi-gateway` namespace has already been created for you
# resource "helm_release" "etcd" {
#   name       = "etcd"
#   namespace = "fdi-gateway"
#
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "etcd"
# }

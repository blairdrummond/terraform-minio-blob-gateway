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

    # kubernetes = {
    #   source = "hashicorp/kubernetes"
    #   version = ">= 2.3.2"
    # }
  }

  required_version = ">= 0.14.9"
}

# We are not actually connecting to AWS
# We're just using a helper function for
# managing IAM policies
provider "aws" {
  region = "us-east-1"
}

# provider "kubernetes" {
#   config_path    = "~/.kube/config"
#   config_context = "my-context"
# }


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
  minio_region = "us-east-1"
  minio_access_key = var.minio_access_key
  minio_secret_key = var.minio_secret_key
}


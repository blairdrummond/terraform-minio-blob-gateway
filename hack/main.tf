# This is a test module to see if the module works

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

    # kubernetes = {
    #   source = "hashicorp/kubernetes"
    #   version = ">= 2.3.2"
    # }
  }

  required_version = ">= 0.14.9"
}


# provider "kubernetes" {
#   config_path    = "~/.kube/config"
#   config_context = "my-context"
# }


# ###
# ###  ooo        ooooo  o8o              ooooo   .oooooo.
# ###  `88.       .888'  `"'              `888'  d8P'  `Y8b
# ###   888b     d'888  oooo  ooo. .oo.    888  888      888
# ###   8 Y88. .P  888  `888  `888P"Y88b   888  888      888
# ###   8  `888'   888   888   888   888   888  888      888
# ###   8    Y     888   888   888   888   888  `88b    d88'
# ###  o8o        o888o o888o o888o o888o o888o  `Y8bood8P'
# ###
#
# provider "minio" {
#   minio_server = var.minio_server
#   minio_region = "us-east-1"
#   minio_access_key = var.minio_access_key
#   minio_secret_key = var.minio_secret_key
# }


#####################################################


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



######################################################

module "datasets" {
  source = "https://github.com/blairdrummond/terraform-minio-blob-gateway?ref=module-ify"

  datasets = {
    cropimaging = {

      kubeflow_readers = ["blair", "jim"]
      kubeflow_writers = ["blair"]

      division = "DScD"
      use_case = "crop imaging"
      contact_email = "blair.drummond@canada.ca"
      cct_score = 0
    }
    frontiercounts = {

      kubeflow_readers = ["jim"]
      kubeflow_writers = []

      division = "CCTTS"
      use_case = "fc"
      contact_email = "blair.drummond@canada.ca"
      cct_score = 5
    }
  }

  storage_account_name = azurerm_storage_account.datalake.name
  storage_account_rg_name = azurerm_resource_group.rg.name

  minio_server = "localhost:9000"
  minio_access_key = "minioadmin"
  minio_secret_key = "minioadmin"

}

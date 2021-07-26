###
###   888888ba             dP                                dP
###   88    `8b            88                                88
###   88     88 .d8888b. d8888P .d8888b. .d8888b. .d8888b. d8888P .d8888b.
###   88     88 88'  `88   88   88'  `88 Y8ooooo. 88ooood8   88   Y8ooooo.
###   88    .8P 88.  .88   88   88.  .88       88 88.  ...   88         88
###   8888888P  `88888P8   dP   `88888P8 `88888P' `88888P'   dP   `88888P'
###


module "cropimaging" {
  # Boilerplate
  source = "./fdi_dataset"
  storage_account = azurerm_storage_account.datalake.name

  # Actual Configuration
  kubeflow_readers = [minio_iam_user.profile_crop_imaging.name]
  kubeflow_writers = [minio_iam_user.profile_crop_imaging.name]
  dataset_name = "crop-imaging"
  division = "DScD"
  use_case = "crop imaging"
  contact_email = "blair.drummond@canada.ca"
  cct_score = 0

  #required_providers {
  #  minio = {
  #    source = "aminueza/minio"
  #    version = ">= 1.0.0"
  #  }
  #}
}

###
###   888888ba             dP                                dP
###   88    `8b            88                                88
###   88     88 .d8888b. d8888P .d8888b. .d8888b. .d8888b. d8888P .d8888b.
###   88     88 88'  `88   88   88'  `88 Y8ooooo. 88ooood8   88   Y8ooooo.
###   88    .8P 88.  .88   88   88.  .88       88 88.  ...   88         88
###   8888888P  `88888P8   dP   `88888P8 `88888P' `88888P'   dP   `88888P'
###

module "dataset" {

  for_each = var.datasets

  source = "./fdi_dataset"
  storage_account = azurerm_storage_account.datalake.name

  kubeflow_readers = each.value.kubeflow_readers
  kubeflow_writers = each.value.kubeflow_writers

  # Actual Configuration
  dataset_name = each.key
  division = each.value.division
  use_case = each.value.use_case
  contact_email = each.value.contact_email
  cct_score = each.value.cct_score
}

output "policies" {
  value = {
    for k, v in module.dataset : k => {
      reader = v.reader
      writer = v.writer
    }
  }
}

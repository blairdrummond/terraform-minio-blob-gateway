data "azurerm_storage_account" "datalake" {
  name                     = var.storage_account_name
  resource_group_name      = var.storage_account_rg_name
}

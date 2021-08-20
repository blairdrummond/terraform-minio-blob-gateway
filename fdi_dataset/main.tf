resource "azurerm_storage_container" "container" {
  name                  = var.dataset_name
  storage_account_name  = var.storage_account
  container_access_type = "private"

  metadata = {
    division = var.division
    use_case = var.use_case
    contact_email = var.contact_email
    cct_score = var.cct_score
  }
}

# # Think we need to look at this
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
# # AD Reader Role
# resource "azurerm_role_assignment" "data-reader-role" {
#   scope                = azurerm_storage_container.container.resource_manager_id
#   role_definition_name = "Storage Blob Reader"
#   principal_id         = "xxxx"
# }




# Reader Policy
data "minio_iam_policy_document" "reader_policy_doc" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "arn:aws:s3:::${azurerm_storage_container.container.name}",
      "arn:aws:s3:::${azurerm_storage_container.container.name}/*",
    ]
  }
}


# Writer Policy
data "minio_iam_policy_document" "writer_policy_doc" {
  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetBucketObjectLockConfiguration",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${azurerm_storage_container.container.name}",
      "arn:aws:s3:::${azurerm_storage_container.container.name}/*",
    ]
  }
}

output "reader" {
  value = data.minio_iam_policy_document.reader_policy_doc
}

output "writer" {
  value = data.minio_iam_policy_document.writer_policy_doc
}

output "kubeflow_readers" {
  value = var.kubeflow_readers
}

output "kubeflow_writers" {
  value = var.kubeflow_writers
}

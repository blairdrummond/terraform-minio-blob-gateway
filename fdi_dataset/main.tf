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



# The FDI team should look at this:
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy

resource "minio_iam_group" "readers_group" {
  name = "${var.dataset_name}-readers"
}

resource "minio_iam_group" "writers_group" {
  name = "${var.dataset_name}-writers"
}

resource "minio_iam_group_membership" "readers_membership" {
  name = "${var.dataset_name}-readers"
  users = var.kubeflow_readers
  group = minio_iam_group.readers_group.name
}

resource "minio_iam_group_membership" "writers_membership" {
  name = "${var.dataset_name}-writers"
  users = var.kubeflow_writers
  group = minio_iam_group.writers_group.name
}

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
resource "minio_iam_policy" "reader_policy" {
  name   = "${var.dataset_name}-reader-policy"
  policy = data.minio_iam_policy_document.reader_policy_doc.json
}
resource "minio_iam_group_policy_attachment" "reader_group_policy" {
    policy_name = minio_iam_policy.reader_policy.name
    group_name = minio_iam_group.readers_group.name
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
resource "minio_iam_policy" "writer_policy" {
  name   = "${var.dataset_name}-writer-policy"
  policy = data.minio_iam_policy_document.writer_policy_doc.json
}
resource "minio_iam_group_policy_attachment" "writer_group_policy" {
    policy_name = minio_iam_policy.writer_policy.name
    group_name = minio_iam_group.writers_group.name
}

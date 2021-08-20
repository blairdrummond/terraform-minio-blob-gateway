# Take
#
#   {
#     "cropimaging": {
#       "readers": ["blair", "jim"]
#       "writers": ["blair"]
#     },
#     "frontiercounts": {
#       "readers": ["jim"]
#     }
#   }
#
# and turn it into
#
#   {
#     "blair": merge(cropimaging.reader, cropimaging.writer),
#     "jim": merge(cropimaging.reader, frontiercounts.reader)
#   }
#
# I.e. "transpose" the datasets with the users and merge
# all the users permissions into a single policy


locals {
  reader_policies = transpose({
    for k, v in module.dataset : k => v.kubeflow_readers
  })

  writer_policies = transpose({
    for k, v in module.dataset : k => v.kubeflow_writers
  })

  all_keys = setunion(keys(local.writer_policies), keys(local.reader_policies))
}

data "aws_iam_policy_document" "combined" {
  for_each = local.all_keys
  source_policy_documents = setunion(
    try([
      for k, v in local.reader_policies[each.key]: module.dataset[v].reader.json
    ], []),
    try([
      for k, v in local.writer_policies[each.key]: module.dataset[v].writer.json
    ], [])
  )
}

resource "minio_iam_policy" "kubeflow_profile" {
  for_each = data.aws_iam_policy_document.combined
  name = each.key
  policy = each.value.json
}

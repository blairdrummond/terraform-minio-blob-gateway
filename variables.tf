# MinIO Configuration

variable "datasets" {
  description = "A bunch of dataset objects to create"
}

# # Example
#
# datasets = {
#   cropimaging = {
#
#     kubeflow_readers = ["blair", "jim"]
#     kubeflow_writers = ["blair"]
#
#     division = "DScD"
#     use_case = "crop imaging"
#     contact_email = "blair.drummond@canada.ca"
#     cct_score = 0
#   }
#   frontiercounts = {
#
#     kubeflow_readers = ["jim"]
#     kubeflow_writers = []
#
#     division = "CCTTS"
#     use_case = "fc"
#     contact_email = "blair.drummond@canada.ca"
#     cct_score = 5
#   }
# }





variable "storage_account_name" {
  description = "The Storage Account Name"
}

variable "storage_account_rg_name" {
  description = "The Storage Account Resource Group"
}




variable "minio_server" {
  description = "Default MINIO host and port"
  default = "localhost:9000"
}

variable "minio_access_key" {
  description = "MINIO user"
  default = "minioadmin"
}

variable "minio_secret_key" {
  description = "MINIO secret user"
  default = "minioadmin"
}

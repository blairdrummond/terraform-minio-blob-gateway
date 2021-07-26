###   _____              __ _
###  /  __ \            / _(_)
###  | /  \/ ___  _ __ | |_ _  __ _
###  | |    / _ \| '_ \|  _| |/ _` |
###  | \__/\ (_) | | | | | | | (_| |
###   \____/\___/|_| |_|_| |_|\__, |
###                            __/ |
###                           |___/

variable "storage_account" {
    type = string
    description = "Storage Account Name"
}

###     #
###    # #
###   #   #   ###    ###    ###    ###    ###
###   #   #  #   #  #   #  #   #  #      #
###   #####  #      #      #####   ###    ###
###   #   #  #   #  #   #  #          #      #
###   #   #   ###    ###    ###   ####   ####
###

variable "kubeflow_readers" {
  description = "List of Kubeflow Readers"
  type = list
  default = []
}

variable "kubeflow_writers" {
  description = "List of Kubeflow Writers"
  type = list
  default = []
}

###  ___  ___     _            _       _
###  |  \/  |    | |          | |     | |
###  | .  . | ___| |_ __ _  __| | __ _| |_ __ _
###  | |\/| |/ _ \ __/ _` |/ _` |/ _` | __/ _` |
###  | |  | |  __/ |_ (_| | (_| | (_| | |_ (_| |
###  \_|  |_/\___|\__\__,_|\__,_|\__,_|\__\__,_|
###

variable "dataset_name" {
    type = string
    description = "The name of this dataset"
}

variable "division" {
    type = string
    description = "The Division owning the datasource"
}

variable "use_case" {
    type = string
    description = "The Use Case this comes from"
}

variable "contact_email" {
    type = string
    description = "The contact email address for this dataset"
}

variable "cct_score" {
    type = number
    description = "The (max) CCT Score of the data"
}



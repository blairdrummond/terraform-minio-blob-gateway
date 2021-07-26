# Put Data Factory Stuff here
# resource "azuread_application" "example" {
#   display_name               = "example"
#   homepage                   = "http://homepage"
#   identifier_uris            = ["http://uri"]
#   reply_urls                 = ["http://replyurl"]
#   available_to_other_tenants = false
#   oauth2_allow_implicit_flow = true
# }
#
# resource "azuread_service_principal" "example" {
#   application_id               = azuread_application.example.application_id
#   app_role_assignment_required = false
#
#   tags = ["example", "tags", "here"]
# }
#
#
# #### Groups and Users?
# resource "azuread_user" "example" {
#   display_name        = "J Doe"
#   password            = "notSecure123"
#   user_principal_name = "jdoe@hashicorp.com"
# }
#
# resource "azuread_group" "example" {
#   display_name = "MyGroup"
#   members = [
#     azuread_user.example.object_id,
#     /* more users */
#   ]
# }

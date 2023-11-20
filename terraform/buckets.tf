# This resource is commented, because it should never be destroyed!
# So I apply this outside from this repo

# resource "google_storage_bucket" "tf-states" {
#   name = "sushi-terraform-states"
#   location = "EU"
#   storage_class = "STANDARD"

#   uniform_bucket_level_access = true
# }
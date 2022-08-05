resource "google_project_service" "datastore_googleapis_com" {
  project = "993143830963"
  service = "datastore.googleapis.com"
}
# terraform import google_project_service.datastore_googleapis_com 993143830963/datastore.googleapis.com

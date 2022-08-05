resource "google_project_service" "bigquerystorage_googleapis_com" {
  project = "993143830963"
  service = "bigquerystorage.googleapis.com"
}
# terraform import google_project_service.bigquerystorage_googleapis_com 993143830963/bigquerystorage.googleapis.com

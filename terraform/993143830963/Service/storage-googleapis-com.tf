resource "google_project_service" "storage_googleapis_com" {
  project = "993143830963"
  service = "storage.googleapis.com"
}
# terraform import google_project_service.storage_googleapis_com 993143830963/storage.googleapis.com

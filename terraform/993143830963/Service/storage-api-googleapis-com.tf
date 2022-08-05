resource "google_project_service" "storage_api_googleapis_com" {
  project = "993143830963"
  service = "storage-api.googleapis.com"
}
# terraform import google_project_service.storage_api_googleapis_com 993143830963/storage-api.googleapis.com

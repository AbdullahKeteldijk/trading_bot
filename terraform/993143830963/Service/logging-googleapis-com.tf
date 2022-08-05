resource "google_project_service" "logging_googleapis_com" {
  project = "993143830963"
  service = "logging.googleapis.com"
}
# terraform import google_project_service.logging_googleapis_com 993143830963/logging.googleapis.com

resource "google_project_service" "cloudapis_googleapis_com" {
  project = "993143830963"
  service = "cloudapis.googleapis.com"
}
# terraform import google_project_service.cloudapis_googleapis_com 993143830963/cloudapis.googleapis.com

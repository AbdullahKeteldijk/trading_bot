resource "google_project_service" "cloudscheduler_googleapis_com" {
  project = "993143830963"
  service = "cloudscheduler.googleapis.com"
}
# terraform import google_project_service.cloudscheduler_googleapis_com 993143830963/cloudscheduler.googleapis.com

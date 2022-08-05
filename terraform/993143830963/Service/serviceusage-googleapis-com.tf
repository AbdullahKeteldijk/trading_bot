resource "google_project_service" "serviceusage_googleapis_com" {
  project = "993143830963"
  service = "serviceusage.googleapis.com"
}
# terraform import google_project_service.serviceusage_googleapis_com 993143830963/serviceusage.googleapis.com

resource "google_project_service" "monitoring_googleapis_com" {
  project = "993143830963"
  service = "monitoring.googleapis.com"
}
# terraform import google_project_service.monitoring_googleapis_com 993143830963/monitoring.googleapis.com

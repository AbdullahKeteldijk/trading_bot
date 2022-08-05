resource "google_project_service" "cloudfunctions_googleapis_com" {
  project = "993143830963"
  service = "cloudfunctions.googleapis.com"
}
# terraform import google_project_service.cloudfunctions_googleapis_com 993143830963/cloudfunctions.googleapis.com

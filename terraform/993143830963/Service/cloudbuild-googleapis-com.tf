resource "google_project_service" "cloudbuild_googleapis_com" {
  project = "993143830963"
  service = "cloudbuild.googleapis.com"
}
# terraform import google_project_service.cloudbuild_googleapis_com 993143830963/cloudbuild.googleapis.com

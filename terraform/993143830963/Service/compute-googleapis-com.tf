resource "google_project_service" "compute_googleapis_com" {
  project = "993143830963"
  service = "compute.googleapis.com"
}
# terraform import google_project_service.compute_googleapis_com 993143830963/compute.googleapis.com

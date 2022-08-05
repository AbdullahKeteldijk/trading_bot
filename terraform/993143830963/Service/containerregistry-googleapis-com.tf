resource "google_project_service" "containerregistry_googleapis_com" {
  project = "993143830963"
  service = "containerregistry.googleapis.com"
}
# terraform import google_project_service.containerregistry_googleapis_com 993143830963/containerregistry.googleapis.com

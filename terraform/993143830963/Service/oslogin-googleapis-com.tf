resource "google_project_service" "oslogin_googleapis_com" {
  project = "993143830963"
  service = "oslogin.googleapis.com"
}
# terraform import google_project_service.oslogin_googleapis_com 993143830963/oslogin.googleapis.com

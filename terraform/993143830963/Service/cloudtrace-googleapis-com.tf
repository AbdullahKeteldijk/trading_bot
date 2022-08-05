resource "google_project_service" "cloudtrace_googleapis_com" {
  project = "993143830963"
  service = "cloudtrace.googleapis.com"
}
# terraform import google_project_service.cloudtrace_googleapis_com 993143830963/cloudtrace.googleapis.com

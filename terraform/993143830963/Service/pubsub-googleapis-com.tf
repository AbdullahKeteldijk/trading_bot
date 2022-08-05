resource "google_project_service" "pubsub_googleapis_com" {
  project = "993143830963"
  service = "pubsub.googleapis.com"
}
# terraform import google_project_service.pubsub_googleapis_com 993143830963/pubsub.googleapis.com

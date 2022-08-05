resource "google_project_service" "bigquery_googleapis_com" {
  project = "993143830963"
  service = "bigquery.googleapis.com"
}
# terraform import google_project_service.bigquery_googleapis_com 993143830963/bigquery.googleapis.com

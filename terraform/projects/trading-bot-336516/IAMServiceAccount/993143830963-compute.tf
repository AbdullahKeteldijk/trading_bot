resource "google_service_account" "993143830963_compute" {
  account_id   = "993143830963-compute"
  display_name = "Compute Engine default service account"
  project      = "trading-bot-336516"
}
# terraform import google_service_account.993143830963_compute projects/trading-bot-336516/serviceAccounts/993143830963-compute@trading-bot-336516.iam.gserviceaccount.com

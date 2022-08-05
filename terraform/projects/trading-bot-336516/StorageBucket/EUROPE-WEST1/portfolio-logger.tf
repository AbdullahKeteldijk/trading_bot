resource "google_storage_bucket" "portfolio_logger" {
  force_destroy               = false
  location                    = "EUROPE-WEST1"
  name                        = "portfolio_logger"
  project                     = "trading-bot-336516"
  public_access_prevention    = "enforced"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}
# terraform import google_storage_bucket.portfolio_logger portfolio_logger

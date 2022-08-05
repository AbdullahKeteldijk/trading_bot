resource "google_storage_bucket" "staging_trading_bot_336516_appspot_com" {
  force_destroy = false

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age        = 15
      with_state = "ANY"
    }
  }

  location                 = "EU"
  name                     = "staging.trading-bot-336516.appspot.com"
  project                  = "trading-bot-336516"
  public_access_prevention = "inherited"
  storage_class            = "STANDARD"
}
# terraform import google_storage_bucket.staging_trading_bot_336516_appspot_com staging.trading-bot-336516.appspot.com

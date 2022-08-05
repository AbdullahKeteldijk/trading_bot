resource "google_storage_bucket" "trading_bot_336516_appspot_com" {
  force_destroy            = false
  location                 = "EU"
  name                     = "trading-bot-336516.appspot.com"
  project                  = "trading-bot-336516"
  public_access_prevention = "inherited"
  storage_class            = "STANDARD"
}
# terraform import google_storage_bucket.trading_bot_336516_appspot_com trading-bot-336516.appspot.com

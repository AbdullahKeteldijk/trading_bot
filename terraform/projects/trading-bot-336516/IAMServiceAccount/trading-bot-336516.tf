resource "google_service_account" "trading_bot_336516" {
  account_id   = "trading-bot-336516"
  display_name = "App Engine default service account"
  project      = "trading-bot-336516"
}
# terraform import google_service_account.trading_bot_336516 projects/trading-bot-336516/serviceAccounts/trading-bot-336516@trading-bot-336516.iam.gserviceaccount.com

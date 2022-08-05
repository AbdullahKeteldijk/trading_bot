resource "google_pubsub_subscription" "gcf_trading_bot_v1_europe_west1_trading_bot_v0" {
  ack_deadline_seconds       = 600
  message_retention_duration = "604800s"
  name                       = "gcf-trading-bot-v1-europe-west1-trading-bot-v0"
  project                    = "trading-bot-336516"

  push_config {
    push_endpoint = "https://d11a8c047001282bae28bffdce466a40-dot-wd98ee21ff09809b5p-tp.appspot.com/_ah/push-handlers/pubsub/projects/trading-bot-336516/topics/trading-bot-v0?pubsub_trigger=true"
  }

  topic = "projects/trading-bot-336516/topics/trading-bot-v0"
}
# terraform import google_pubsub_subscription.gcf_trading_bot_v1_europe_west1_trading_bot_v0 projects/trading-bot-336516/subscriptions/gcf-trading-bot-v1-europe-west1-trading-bot-v0

resource "google_pubsub_topic" "trading_bot_v0" {
  name    = "trading-bot-v0"
  project = "trading-bot-336516"
}
# terraform import google_pubsub_topic.trading_bot_v0 projects/trading-bot-336516/topics/trading-bot-v0

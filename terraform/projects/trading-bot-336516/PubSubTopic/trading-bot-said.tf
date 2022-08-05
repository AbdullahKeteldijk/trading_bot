resource "google_pubsub_topic" "trading_bot_said" {
  name    = "trading-bot-said"
  project = "trading-bot-336516"
}
# terraform import google_pubsub_topic.trading_bot_said projects/trading-bot-336516/topics/trading-bot-said

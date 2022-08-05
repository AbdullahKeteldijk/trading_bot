resource "google_pubsub_topic" "trading_bot_papa" {
  name    = "trading-bot-papa"
  project = "trading-bot-336516"
}
# terraform import google_pubsub_topic.trading_bot_papa projects/trading-bot-336516/topics/trading-bot-papa

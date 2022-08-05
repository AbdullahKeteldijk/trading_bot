resource "google_pubsub_topic" "hype_bot_v1" {
  name    = "hype-bot-v1"
  project = "trading-bot-336516"
}
# terraform import google_pubsub_topic.hype_bot_v1 projects/trading-bot-336516/topics/hype-bot-v1

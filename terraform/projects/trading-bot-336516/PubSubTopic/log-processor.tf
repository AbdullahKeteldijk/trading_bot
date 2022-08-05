resource "google_pubsub_topic" "log_processor" {
  name    = "log-processor"
  project = "trading-bot-336516"
}
# terraform import google_pubsub_topic.log_processor projects/trading-bot-336516/topics/log-processor

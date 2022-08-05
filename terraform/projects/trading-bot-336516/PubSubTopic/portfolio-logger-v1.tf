resource "google_pubsub_topic" "portfolio_logger_v1" {
  name    = "portfolio-logger-v1"
  project = "trading-bot-336516"
}
# terraform import google_pubsub_topic.portfolio_logger_v1 projects/trading-bot-336516/topics/portfolio-logger-v1

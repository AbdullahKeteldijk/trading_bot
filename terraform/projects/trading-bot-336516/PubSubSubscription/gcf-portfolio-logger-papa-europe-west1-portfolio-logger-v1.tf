resource "google_pubsub_subscription" "gcf_portfolio_logger_papa_europe_west1_portfolio_logger_v1" {
  ack_deadline_seconds       = 600
  message_retention_duration = "604800s"
  name                       = "gcf-portfolio-logger_papa-europe-west1-portfolio-logger-v1"
  project                    = "trading-bot-336516"

  push_config {
    push_endpoint = "https://ca235918bb087944b0870a5d77ae056a-dot-wd98ee21ff09809b5p-tp.appspot.com/_ah/push-handlers/pubsub/projects/trading-bot-336516/topics/portfolio-logger-v1?pubsub_trigger=true"
  }

  topic = "projects/trading-bot-336516/topics/portfolio-logger-v1"
}
# terraform import google_pubsub_subscription.gcf_portfolio_logger_papa_europe_west1_portfolio_logger_v1 projects/trading-bot-336516/subscriptions/gcf-portfolio-logger_papa-europe-west1-portfolio-logger-v1

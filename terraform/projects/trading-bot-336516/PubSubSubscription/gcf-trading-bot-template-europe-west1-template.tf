resource "google_pubsub_subscription" "gcf_trading_bot_template_europe_west1_template" {
  ack_deadline_seconds       = 600
  message_retention_duration = "604800s"
  name                       = "gcf-trading-bot-template-europe-west1-template"
  project                    = "trading-bot-336516"

  push_config {
    push_endpoint = "https://dfbc3e85ac7d2e573f8f8a0ffc26b153-dot-wd98ee21ff09809b5p-tp.appspot.com/_ah/push-handlers/pubsub/projects/trading-bot-336516/topics/template?pubsub_trigger=true"
  }

  topic = "projects/trading-bot-336516/topics/template"
}
# terraform import google_pubsub_subscription.gcf_trading_bot_template_europe_west1_template projects/trading-bot-336516/subscriptions/gcf-trading-bot-template-europe-west1-template

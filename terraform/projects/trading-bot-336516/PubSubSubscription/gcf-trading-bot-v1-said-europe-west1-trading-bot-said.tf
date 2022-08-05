resource "google_pubsub_subscription" "gcf_trading_bot_v1_said_europe_west1_trading_bot_said" {
  ack_deadline_seconds       = 600
  message_retention_duration = "604800s"
  name                       = "gcf-trading-bot-v1-said-europe-west1-trading-bot-said"
  project                    = "trading-bot-336516"

  push_config {
    push_endpoint = "https://7d3ec9bd9611c0447d82554bae69e8d6-dot-wd98ee21ff09809b5p-tp.appspot.com/_ah/push-handlers/pubsub/projects/trading-bot-336516/topics/trading-bot-said?pubsub_trigger=true"
  }

  topic = "projects/trading-bot-336516/topics/trading-bot-said"
}
# terraform import google_pubsub_subscription.gcf_trading_bot_v1_said_europe_west1_trading_bot_said projects/trading-bot-336516/subscriptions/gcf-trading-bot-v1-said-europe-west1-trading-bot-said

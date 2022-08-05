resource "google_pubsub_subscription" "gcf_trading_bot_v1_papa_europe_west1_trading_bot_papa" {
  ack_deadline_seconds       = 600
  message_retention_duration = "604800s"
  name                       = "gcf-trading-bot-v1-papa-europe-west1-trading-bot-papa"
  project                    = "trading-bot-336516"

  push_config {
    push_endpoint = "https://356ae58eb6e083495d0b3ddb23b6f319-dot-wd98ee21ff09809b5p-tp.appspot.com/_ah/push-handlers/pubsub/projects/trading-bot-336516/topics/trading-bot-papa?pubsub_trigger=true"
  }

  topic = "projects/trading-bot-336516/topics/trading-bot-papa"
}
# terraform import google_pubsub_subscription.gcf_trading_bot_v1_papa_europe_west1_trading_bot_papa projects/trading-bot-336516/subscriptions/gcf-trading-bot-v1-papa-europe-west1-trading-bot-papa

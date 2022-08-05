resource "google_pubsub_subscription" "gcf_hype_bot_v1_europe_west1_hype_bot_v1" {
  ack_deadline_seconds       = 600
  message_retention_duration = "604800s"
  name                       = "gcf-hype-bot-v1-europe-west1-hype-bot-v1"
  project                    = "trading-bot-336516"

  push_config {
    push_endpoint = "https://474bedd44042ac656468400cd405245b-dot-wd98ee21ff09809b5p-tp.appspot.com/_ah/push-handlers/pubsub/projects/trading-bot-336516/topics/hype-bot-v1?pubsub_trigger=true"
  }

  topic = "projects/trading-bot-336516/topics/hype-bot-v1"
}
# terraform import google_pubsub_subscription.gcf_hype_bot_v1_europe_west1_hype_bot_v1 projects/trading-bot-336516/subscriptions/gcf-hype-bot-v1-europe-west1-hype-bot-v1

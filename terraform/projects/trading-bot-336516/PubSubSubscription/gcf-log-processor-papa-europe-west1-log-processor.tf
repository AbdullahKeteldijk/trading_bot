resource "google_pubsub_subscription" "gcf_log_processor_papa_europe_west1_log_processor" {
  ack_deadline_seconds       = 600
  message_retention_duration = "604800s"
  name                       = "gcf-log-processor-papa-europe-west1-log-processor"
  project                    = "trading-bot-336516"

  push_config {
    push_endpoint = "https://1bb7c86e25782e14f57a54495e2d8638-dot-wd98ee21ff09809b5p-tp.appspot.com/_ah/push-handlers/pubsub/projects/trading-bot-336516/topics/log-processor?pubsub_trigger=true"
  }

  topic = "projects/trading-bot-336516/topics/log-processor"
}
# terraform import google_pubsub_subscription.gcf_log_processor_papa_europe_west1_log_processor projects/trading-bot-336516/subscriptions/gcf-log-processor-papa-europe-west1-log-processor

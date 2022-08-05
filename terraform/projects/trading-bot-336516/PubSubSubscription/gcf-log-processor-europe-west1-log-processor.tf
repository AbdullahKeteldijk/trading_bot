resource "google_pubsub_subscription" "gcf_log_processor_europe_west1_log_processor" {
  ack_deadline_seconds       = 600
  message_retention_duration = "604800s"
  name                       = "gcf-log-processor-europe-west1-log-processor"
  project                    = "trading-bot-336516"

  push_config {
    push_endpoint = "https://aa9d96f8fbdf745ad72268f7bf30b96e-dot-wd98ee21ff09809b5p-tp.appspot.com/_ah/push-handlers/pubsub/projects/trading-bot-336516/topics/log-processor?pubsub_trigger=true"
  }

  topic = "projects/trading-bot-336516/topics/log-processor"
}
# terraform import google_pubsub_subscription.gcf_log_processor_europe_west1_log_processor projects/trading-bot-336516/subscriptions/gcf-log-processor-europe-west1-log-processor

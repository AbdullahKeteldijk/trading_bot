resource "google_pubsub_topic" "template" {
  name    = "template"
  project = "trading-bot-336516"
}
# terraform import google_pubsub_topic.template projects/trading-bot-336516/topics/template

resource "google_compute_address" "nb" {
  address      = "34.79.252.179"
  address_type = "EXTERNAL"
  name         = "nb"
  network_tier = "PREMIUM"
  project      = "trading-bot-336516"
  region       = "europe-west1"
}
# terraform import google_compute_address.nb projects/trading-bot-336516/regions/europe-west1/addresses/nb

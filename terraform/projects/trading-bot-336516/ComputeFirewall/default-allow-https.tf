resource "google_compute_firewall" "default_allow_https" {
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "default-allow-https"
  network       = "https://www.googleapis.com/compute/v1/projects/trading-bot-336516/global/networks/default"
  priority      = 1000
  project       = "trading-bot-336516"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}
# terraform import google_compute_firewall.default_allow_https projects/trading-bot-336516/global/firewalls/default-allow-https

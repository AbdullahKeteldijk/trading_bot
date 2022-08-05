resource "google_compute_firewall" "default_allow_icmp" {
  allow {
    protocol = "icmp"
  }

  description   = "Allow ICMP from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-icmp"
  network       = "https://www.googleapis.com/compute/v1/projects/trading-bot-336516/global/networks/default"
  priority      = 65534
  project       = "trading-bot-336516"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.default_allow_icmp projects/trading-bot-336516/global/firewalls/default-allow-icmp

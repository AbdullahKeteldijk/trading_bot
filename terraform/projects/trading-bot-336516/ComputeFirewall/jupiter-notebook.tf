resource "google_compute_firewall" "jupiter_notebook" {
  allow {
    ports    = ["8888"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "jupiter-notebook"
  network       = "https://www.googleapis.com/compute/v1/projects/trading-bot-336516/global/networks/default"
  priority      = 1000
  project       = "trading-bot-336516"
  source_ranges = ["0.0.0.0/0"]
}
# terraform import google_compute_firewall.jupiter_notebook projects/trading-bot-336516/global/firewalls/jupiter-notebook

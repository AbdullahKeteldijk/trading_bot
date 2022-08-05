resource "google_storage_bucket" "gcf_sources_993143830963_europe_west1" {
  cors {
    method = ["GET"]
    origin = ["https://*.cloud.google.com", "https://*.corp.google.com", "https://*.corp.google.com:*"]
  }

  force_destroy               = false
  location                    = "EUROPE-WEST1"
  name                        = "gcf-sources-993143830963-europe-west1"
  project                     = "trading-bot-336516"
  public_access_prevention    = "inherited"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}
# terraform import google_storage_bucket.gcf_sources_993143830963_europe_west1 gcf-sources-993143830963-europe-west1

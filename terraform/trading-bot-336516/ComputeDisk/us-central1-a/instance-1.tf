resource "google_compute_disk" "instance_1" {
  image                     = "https://www.googleapis.com/compute/beta/projects/ml-images/global/images/c2-deeplearning-pytorch-1-10-xla-v20211219-debian-10"
  name                      = "instance-1"
  physical_block_size_bytes = 4096
  project                   = "trading-bot-336516"
  size                      = 50
  type                      = "pd-balanced"
  zone                      = "us-central1-a"
}
# terraform import google_compute_disk.instance_1 projects/trading-bot-336516/zones/us-central1-a/disks/instance-1

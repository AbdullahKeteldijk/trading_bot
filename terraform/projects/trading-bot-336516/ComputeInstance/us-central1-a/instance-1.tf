resource "google_compute_instance" "instance_1" {
  boot_disk {
    auto_delete = true
    device_name = "instance-1"

    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/ml-images/global/images/c2-deeplearning-pytorch-1-10-xla-v20211219-debian-10"
      size  = 50
      type  = "pd-balanced"
    }

    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/trading-bot-336516/zones/us-central1-a/disks/instance-1"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  machine_type = "e2-medium"
  name         = "instance-1"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    network            = "https://www.googleapis.com/compute/v1/projects/trading-bot-336516/global/networks/default"
    network_ip         = "10.128.0.2"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/trading-bot-336516/regions/us-central1/subnetworks/default"
    subnetwork_project = "trading-bot-336516"
  }

  project = "trading-bot-336516"

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
    preemptible         = true
  }

  service_account {
    email  = "993143830963-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]
  zone = "us-central1-a"
}
# terraform import google_compute_instance.instance_1 projects/trading-bot-336516/zones/us-central1-a/instances/instance-1

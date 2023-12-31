resource "google_compute_subnetwork" "k8s-private" {
  name = "k8s-private"
  region = var.region
  network = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.0.0/18"
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.48.0.0/14"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/20"
  }
}
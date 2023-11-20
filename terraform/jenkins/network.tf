resource "google_compute_network" "vpc_network" {
  name = var.vcp_name
}

resource "google_compute_firewall" "rules" {
  project = var.project
  name = var.jenkins_hostname
  network = google_compute_network.vpc_network.name

  allow {
    protocol = var.protocol
    ports = var.ports
  }
  #source_tags = var.vm_tags
  target_tags = var.vm_tags
  source_ranges = var.allowed_ip_addresses
}

resource "google_compute_address" "default" {
  name = "jenkins-static-address"
  region = var.region
}

resource "google_compute_global_address" "default" {
  project = var.project
  name = "jenkins-ipv6"
  address_type = "EXTERNAL"
  ip_version = "IPV6"
}
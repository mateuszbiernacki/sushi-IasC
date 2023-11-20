terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}


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

resource "google_compute_instance" "vm_instance" {
  name = var.jenkins_hostname
  machine_type = var.machine_type
  tags = var.vm_tags

  boot_disk {
    initialize_params {
      image = var.vm_image
      size = var.vm_size
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      nat_ip = google_compute_address.default.address
    }
  }


  metadata = {
    startup-script-url = var.startup-script-url
  }


  desired_status = var.status
}


resource "google_compute_instance" "vm_slave" {
  name = var.slaves_hostname
  machine_type = var.machine_type
  tags = var.vm_tags

  boot_disk {
    initialize_params {
      image = var.vm_image
      size = var.vm_size
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      
    }
  }


  metadata = {
    startup-script-url = var.startup-script-url
  }
  desired_status = var.status
}
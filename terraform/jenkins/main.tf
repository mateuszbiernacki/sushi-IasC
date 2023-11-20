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
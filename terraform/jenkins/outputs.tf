output "jenkins_internal_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.network_ip
}

output "jenkins_external_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}


output "slaves_internal_ip" {
  value = google_compute_instance.vm_slave.network_interface.0.network_ip
}

output "slaves_external_ip" {
  value = google_compute_instance.vm_slave.network_interface.0.access_config.0.nat_ip
}
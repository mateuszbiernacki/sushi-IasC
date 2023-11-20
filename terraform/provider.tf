terraform {
  backend "gcs" {
    # Needed to exec below bash command before init (ofc you need to copy this file to own machine)
    # export GOOGLE_APPLICATION_CREDENTIALS=~/.keys/sushi-factory-system-855f86a84d66.json 
    bucket = "sushi-terraform-states"
    prefix = "terraform/state"
  }

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

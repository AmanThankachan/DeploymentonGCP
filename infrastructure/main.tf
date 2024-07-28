provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.vpc_network.self_link
  region        = var.region
}

resource "google_compute_firewall" "firewall_rules" {
  name    = "allow-http-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "app_server" {
  name         = "app-server"
  machine_type = "e2-medium"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnet.name

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    email  = google_service_account.default.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    ssh-keys = <<EOF
    ${var.ssh_user}:${file(var.ssh_pub_key)}
    EOF
  }
}

resource "google_sql_database_instance" "db_instance" {
  name             = "example-db-instance"
  database_version = "POSTGRES_12"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
      require_ssl  = true
    }
  }
}

resource "google_sql_database" "database" {
  name     = "exampledb"
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_user" "db_user" {
  name     = "appuser"
  instance = google_sql_database_instance.db_instance.name
  password = "appuser_password"
}

resource "google_service_account" "default" {
  account_id   = "terraform-service-account"
  display_name = "Terraform Service Account"
}

resource "google_project_iam_member" "app_server_sa_role" {
  role   = "roles/compute.instanceAdmin.v1"
  member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "sql_sa_role" {
  role   = "roles/cloudsql.client"
  member = "serviceAccount:${google_service_account.default.email}"
}

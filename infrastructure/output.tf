output "app_server_ip" {
  description = "The IP address of the application server"
  value       = google_compute_instance.app_server.network_interface[0].access_config[0].nat_ip
}

output "db_instance_connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.db_instance.connection_name
}

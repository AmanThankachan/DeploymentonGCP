variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "ssh_user" {
  description = "SSH username"
  type        = string
}

variable "ssh_pub_key" {
  description = "Path to the SSH public key"
  type        = string
}

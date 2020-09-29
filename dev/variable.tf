variable "gcp_credentials_file_path" {
  description = "Locate the GCP credentials .json file."
  default        = "/Users/soumya/workspace/gcp_service_acoount_credential/sa.json"
}

variable "gcp_project_id" {
  description = "GCP Project ID."
  default        = "nodal-magnet-289714"
}

variable "gcp_region" {
  description = "Default to Oregon region."
  default     = "us-central1"
}

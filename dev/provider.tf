
provider "google" {
  version = "~> 3.19.0"
  credentials = file(var.gcp_credentials_file_path)
  project = var.gcp_project_id
  region = var.gcp_region

  }

  provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
    }
  provider "azurerm" {

  version = "=2.20.0"

}

/*
 * Copyright 2020 techinducers Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * Terraform gcp compute vm creation
 */

 resource "google_compute_address" "gcp-ip" {
   #count  = var.gcp_instance_count
   name  = "gcp-vm-ip-${var.gcp_region}"
   region = var.gcp_region
 }

 resource "google_compute_instance" "gcp-vm" {
   name         = "gcp-vm-${var.gcp_region}"
   machine_type = var.gcp_instance_type
   #zone         = data.google_compute_zones.available.names[0]
   zone          = "us-central1-a"

   boot_disk {
     initialize_params {
       image = var.gcp_disk_image
     }
   }

   network_interface {
     subnetwork = google_compute_subnetwork.gcp-subnet1.name
     network_ip = var.gcp_vm_address

     access_config {
       # Static IP
       nat_ip = google_compute_address.gcp-ip.address
     }
   }
   }

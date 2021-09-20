/* 
Copyright 2021 Google LLC. This software is provided as-is, without warranty or representation for any use or purpose. 
Your use of it is subject to your agreement with Google.
*/

data "google_project" "project_dataproc" {
  project_id = var.project_id
}

resource "google_dataproc_cluster" "mycluster" {
  depends_on                    = [google_compute_firewall.dataproc]
  name                          = var.cluster_name
  region                        = var.region
  project                       = var.project_id
  graceful_decommission_timeout = "120s"
  labels = {
    foo = "bar"
  }

  cluster_config {
    staging_bucket = var.storage_bucket

    master_config {
      num_instances = 1
      machine_type  = "e2-medium"
      disk_config {
        boot_disk_size_gb = 30
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = "e2-medium"
      disk_config {
        boot_disk_size_gb = 30
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    gce_cluster_config {
      tags       = ["dataproc-${var.cluster_name}"]
      # network    = var.network
      subnetwork = var.subnet
      internal_ip_only  = true
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      service_account = google_service_account.dataproc_service_account.email
      service_account_scopes = [
        "cloud-platform"
      ]
    }
    encryption_config {
      kms_key_name = "projects/${var.project_id}/locations/${var.region}/keyRings/${var.kms_keyring}/cryptoKeys/${var.kms_key}"
    }
  }
}



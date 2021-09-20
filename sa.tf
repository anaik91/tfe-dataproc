locals {
  roles = [
    "roles/cloudkms.cryptoKeyEncrypterDecrypter",
    "roles/dataproc.worker",
    "roles/logging.logWriter"
  ]
}

resource "google_service_account" "dataproc_service_account" {
  project      = var.project_id
  account_id   = "dataproc-sa"
  display_name = "Dataproc Service Account"
}

# data "google_compute_default_service_account" "default" {
#     project = var.project_id
# }

resource "google_project_iam_member" "iam-policy-compute-sa" {
  for_each = toset(local.roles)
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${google_service_account.dataproc_service_account.email}"
}

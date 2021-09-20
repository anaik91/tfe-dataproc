resource "google_kms_key_ring" "dataproc-keyring" {
  project  = var.project_id
  name     = var.kms_keyring
  location = var.region
}

resource "google_kms_crypto_key" "dataproc-crypto-key" {
  name            = var.kms_key
  key_ring        = google_kms_key_ring.dataproc-keyring.id
  rotation_period = "86400s"
}

resource "google_kms_crypto_key_iam_member" "compute_encrypto_key" {
  crypto_key_id = google_kms_crypto_key.dataproc-crypto-key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.project_dataproc.number}@compute-system.iam.gserviceaccount.com"
}

data "google_storage_project_service_account" "gcs_account" {
  project = var.project_id
}

resource "google_kms_crypto_key_iam_member" "storage_encrypto_key" {
  crypto_key_id = google_kms_crypto_key.dataproc-crypto-key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}
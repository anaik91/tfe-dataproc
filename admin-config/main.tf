locals {
  project_id = "PROJECT"
  apis = [
    "dataproc.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]
  roles = [
    "roles/cloudkms.admin",
    "roles/dataproc.admin"
  ]
  sa = "terraf@${local.project_id}.iam.gserviceaccount.com"
}

resource "google_project_service" "gcp_services" {
  for_each                   = toset(local.apis)
  project                    = local.project_id
  service                    = each.key
  disable_dependent_services = true
}

resource "google_project_iam_member" "iam-policy-user" {
  for_each = toset(local.roles)
  project  = local.project_id
  role     = each.key
  member   = "serviceAccount:${local.sa}"
}
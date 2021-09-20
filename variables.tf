/* 
Copyright 2021 Google LLC. This software is provided as-is, without warranty or representation for any use or purpose. 
Your use of it is subject to your agreement with Google.
*/


variable "storage_bucket" {
  description = "bucket"
  type        = string
}


variable "kms_keyring" {
  description = "key ring name"
  type        = string
}

variable "region" {
  description = "region name"
  type        = string
}

variable "kms_key" {
  description = "key  name"
  type        = string
}


variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "network" {
  description = "vpc name"
  type        = string
}

variable "subnet" {
  description = "subnet name"
  type        = string
}

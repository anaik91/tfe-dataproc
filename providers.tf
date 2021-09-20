/* 
Copyright 2021 Google LLC. This software is provided as-is, without warranty or representation for any use or purpose. 
Your use of it is subject to your agreement with Google.
*/

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.69"
    }
  }
}

/******************************************
  Provider credential configuration
 *****************************************/
provider "google" {
  # user_project_override = false
  # credentials           = file("my-project-d358100c9524.json")
  alias                 = "create_dataset"
  user_project_override = true
  access_token          = var.access_token
}

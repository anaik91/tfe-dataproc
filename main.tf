/* 
Copyright 2021 Google LLC. This software is provided as-is, without warranty or representation for any use or purpose. 
Your use of it is subject to your agreement with Google.
*/
/******************************************
  Provider credential configuration
 *****************************************/
provider "google" {
  user_project_override = true
  access_token          = var.access_token
}

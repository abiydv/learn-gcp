terraform {
 backend "gcs" {
   bucket  = "tools-202011"
   prefix  = "terraform/day1-state"
 }
}

provider "google" {
  region  = "us-central1"
}

data "archive_file" "function_archive" {
  type         = "zip"
  source_dir   = "src"
  output_path  = "greet.zip"
}

variable "project" {
    default = "tools-202011"
}

locals {
  timestamp   = formatdate("YYMMDDhhmm", timestamp())
  bucket = "tools-202011"
}


resource "google_storage_bucket_object" "archive" {
  name   = "fsource/greet_${local.timestamp}.zip"
  bucket = local.bucket
  source = "greet.zip"
  content_disposition = "attachment"
  content_encoding    = "gzip"
  content_type        = "application/zip"
}

resource "google_cloudfunctions_function" "function" {
  name        = "greet"
  description = "i greet everyone"
  runtime     = "python37"
  project = var.project

  available_memory_mb   = 128
  source_archive_bucket = local.bucket
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  ingress_settings      = "ALLOW_ALL"
  entry_point           = "http"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

output "url" {
  value = google_cloudfunctions_function.function.https_trigger_url
  
}
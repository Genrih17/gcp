resource "google_project_service" "run_api" {
  service = "run.googleapis.com"
  disable_on_destroy = true
}

resource "google_cloud_run_service" "run_service" {
  name = "app"
  location = var.zone
  template {
    spec {
      service_account_name = google_service_account.service-deploy.email
      containers {
        image = "gcr.io/arcane-shape-319007/lask-image"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
  depends_on = [google_project_service.run_api]
}

output "url" {
  value = "${google_cloud_run_service.run_service.status[0].url}"
}
